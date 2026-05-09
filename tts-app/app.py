#!/usr/bin/env python3
"""
Offline Text-to-Speech (TTS) Application
Uses pyttsx3 for 100% offline TTS functionality
"""

from flask import Flask, render_template, request, jsonify
import pyttsx3
import threading
import os
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Initialize TTS engine
engine = pyttsx3.init()

# Global state management
tts_state = {
    'is_playing': False,
    'is_paused': False,
    'current_text': '',
    'lock': threading.Lock()
}

# Audio settings defaults
DEFAULT_SETTINGS = {
    'volume': 100,
    'rate': 150,
    'pitch': 1.0,
    'language': 'en'
}

def get_available_voices():
    """Get all available system voices"""
    voices_list = []
    try:
        voices = engine.getProperty('voices')
        for i, voice in enumerate(voices):
            voice_info = {
                'id': i,
                'name': voice.name,
                'gender': voice.gender if hasattr(voice, 'gender') else 'Unknown',
                'lang': voice.languages[0] if hasattr(voice, 'languages') and voice.languages else 'Unknown'
            }
            voices_list.append(voice_info)
    except Exception as e:
        print(f"Error getting voices: {e}")
    return voices_list

def on_start(name):
    """Called when TTS starts"""
    tts_state['is_playing'] = True
    tts_state['is_paused'] = False

def on_complete(name, completed):
    """Called when TTS completes"""
    tts_state['is_playing'] = False

@app.route('/')
def index():
    """Render main page"""
    return render_template('index.html')

@app.route('/api/voices', methods=['GET'])
def get_voices():
    """API endpoint to get all available voices"""
    try:
        voices = get_available_voices()
        return jsonify({
            'success': True,
            'voices': voices,
            'default_language': DEFAULT_SETTINGS['language']
        })
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/speak', methods=['POST'])
def speak():
    """API endpoint to speak text"""
    try:
        data = request.get_json()
        text = data.get('text', '').strip()
        volume = data.get('volume', DEFAULT_SETTINGS['volume']) / 100.0
        rate = data.get('rate', DEFAULT_SETTINGS['rate'])
        pitch = data.get('pitch', DEFAULT_SETTINGS['pitch'])
        voice_id = data.get('voice_id', 0)
        language = data.get('language', DEFAULT_SETTINGS['language'])

        if not text:
            return jsonify({'success': False, 'error': 'Text cannot be empty'}), 400

        with tts_state['lock']:
            if tts_state['is_playing']:
                return jsonify({'success': False, 'error': 'Already speaking'}), 400

            try:
                # Set voice
                voices = engine.getProperty('voices')
                if 0 <= voice_id < len(voices):
                    engine.setProperty('voice', voices[voice_id].id)

                # Set audio properties
                engine.setProperty('volume', volume)
                engine.setProperty('rate', rate)
                engine.setProperty('pitch', pitch)

                # Store current text for state management
                tts_state['current_text'] = text
                tts_state['is_playing'] = True
                tts_state['is_paused'] = False

                # Run TTS in a separate thread to avoid blocking
                def speak_thread():
                    try:
                        engine.say(text)
                        engine.runAndWait()
                    except Exception as e:
                        print(f"Error during speech: {e}")
                    finally:
                        tts_state['is_playing'] = False

                thread = threading.Thread(target=speak_thread, daemon=True)
                thread.start()

                return jsonify({
                    'success': True,
                    'message': 'Speaking...',
                    'text_length': len(text)
                })
            except Exception as e:
                tts_state['is_playing'] = False
                return jsonify({'success': False, 'error': str(e)}), 500

    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/stop', methods=['POST'])
def stop_speaking():
    """API endpoint to stop speaking"""
    try:
        with tts_state['lock']:
            engine.stop()
            tts_state['is_playing'] = False
            tts_state['is_paused'] = False
            tts_state['current_text'] = ''
        return jsonify({'success': True, 'message': 'Speech stopped'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/status', methods=['GET'])
def get_status():
    """API endpoint to get current TTS status"""
    return jsonify({
        'is_playing': tts_state['is_playing'],
        'is_paused': tts_state['is_paused'],
        'current_text': tts_state['current_text']
    })

@app.route('/api/test-voices', methods=['GET'])
def test_voices():
    """API endpoint to test speak with each voice"""
    try:
        data = request.get_json() if request.is_json else {}
        voice_id = data.get('voice_id', 0)
        language = data.get('language', 'en')
        
        text = "Hello, this is a test." if language == 'en' else "السلام عليكم"
        
        voices = engine.getProperty('voices')
        if 0 <= voice_id < len(voices):
            engine.setProperty('voice', voices[voice_id].id)
        
        engine.setProperty('volume', 1.0)
        engine.setProperty('rate', 150)
        
        def test_speak():
            try:
                engine.say(text)
                engine.runAndWait()
            except Exception as e:
                print(f"Error during test: {e}")
        
        thread = threading.Thread(target=test_speak, daemon=True)
        thread.start()
        
        return jsonify({'success': True, 'message': 'Testing voice...'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

if __name__ == '__main__':
    print("Available Voices:")
    for voice in get_available_voices():
        print(f"  - {voice['name']} ({voice['lang']})")
    
    # Get configuration from environment or use defaults
    debug_mode = os.getenv('FLASK_DEBUG', 'True').lower() == 'true'
    host = os.getenv('FLASK_HOST', '0.0.0.0')
    port = int(os.getenv('FLASK_PORT', 5000))
    
    # Run Flask app
    app.run(debug=debug_mode, host=host, port=port)
