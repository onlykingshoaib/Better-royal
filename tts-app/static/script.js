/**
 * Offline Text-to-Speech Tool - Frontend Script
 * Handles UI interactions and API communication
 */

// DOM Elements
const textInput = document.getElementById('textInput');
const charCount = document.getElementById('charCount');
const voiceSelect = document.getElementById('voiceSelect');
const testVoiceBtn = document.getElementById('testVoiceBtn');
const playBtn = document.getElementById('playBtn');
const stopBtn = document.getElementById('stopBtn');
const volumeSlider = document.getElementById('volumeSlider');
const volumeValue = document.getElementById('volumeValue');
const rateSlider = document.getElementById('rateSlider');
const rateValue = document.getElementById('rateValue');
const pitchSlider = document.getElementById('pitchSlider');
const pitchValue = document.getElementById('pitchValue');
const statusMessage = document.getElementById('statusMessage');
const statusIndicator = document.getElementById('statusIndicator');
const statusText = document.getElementById('statusText');

// Application State
let appState = {
    isPlaying: false,
    isPaused: false,
    currentVoices: [],
    selectedVoiceId: 0
};

// ============================================
// Initialization
// ============================================

document.addEventListener('DOMContentLoaded', () => {
    console.log('🎙️ Offline TTS Tool - Initializing...');
    loadVoices();
    setupEventListeners();
    updateStatusUI('Ready');
});

// ============================================
// Voice Management
// ============================================

async function loadVoices() {
    try {
        const response = await fetch('/api/voices');
        const data = await response.json();

        if (data.success) {
            appState.currentVoices = data.voices;
            populateVoiceSelect(data.voices);
            updateStatus(`Loaded ${data.voices.length} voices`, 'success');
        } else {
            updateStatus('Failed to load voices', 'error');
            console.error('Error loading voices:', data.error);
        }
    } catch (error) {
        updateStatus('Connection error while loading voices', 'error');
        console.error('Error loading voices:', error);
    }
}

function populateVoiceSelect(voices) {
    voiceSelect.innerHTML = '';

    if (voices.length === 0) {
        voiceSelect.innerHTML = '<option>No voices available</option>';
        return;
    }

    voices.forEach((voice, index) => {
        const option = document.createElement('option');
        option.value = index;
        option.textContent = `${voice.name}`;
        
        // Add language info if available
        if (voice.lang && voice.lang !== 'Unknown') {
            option.textContent += ` (${voice.lang})`;
        }
        
        // Add gender info if available
        if (voice.gender && voice.gender !== 'Unknown') {
            option.textContent += ` - ${voice.gender}`;
        }

        voiceSelect.appendChild(option);
    });

    // Select first voice by default
    voiceSelect.value = 0;
    appState.selectedVoiceId = 0;
}

// ============================================
// Event Listeners Setup
// ============================================

function setupEventListeners() {
    // Text input
    textInput.addEventListener('input', updateCharCount);

    // Buttons
    playBtn.addEventListener('click', handlePlay);
    stopBtn.addEventListener('click', handleStop);
    testVoiceBtn.addEventListener('click', handleTestVoice);

    // Voice selection
    voiceSelect.addEventListener('change', (e) => {
        appState.selectedVoiceId = parseInt(e.target.value);
    });

    // Sliders
    volumeSlider.addEventListener('input', updateVolumeDisplay);
    rateSlider.addEventListener('input', updateRateDisplay);
    pitchSlider.addEventListener('input', updatePitchDisplay);

    // Status polling (check every 500ms)
    setInterval(pollStatus, 500);
}

// ============================================
// Text Input Handlers
// ============================================

function updateCharCount() {
    const count = textInput.value.length;
    charCount.textContent = `${count.toLocaleString()} characters`;

    if (count > 0) {
        playBtn.disabled = false;
    } else {
        playBtn.disabled = true;
    }
}

// ============================================
// Control Handlers
// ============================================

async function handlePlay() {
    const text = textInput.value.trim();

    if (!text) {
        updateStatus('Please enter some text', 'error');
        return;
    }

    if (appState.isPlaying) {
        updateStatus('Already speaking', 'error');
        return;
    }

    const speakData = {
        text: text,
        volume: parseInt(volumeSlider.value),
        rate: parseInt(rateSlider.value),
        pitch: parseFloat(pitchSlider.value),
        voice_id: appState.selectedVoiceId,
        language: 'en'
    };

    try {
        playBtn.disabled = true;
        updateStatus('Speaking...', 'playing');

        const response = await fetch('/api/speak', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(speakData)
        });

        const data = await response.json();

        if (data.success) {
            appState.isPlaying = true;
            statusMessage.textContent = `Playing (${data.text_length} characters)`;
        } else {
            updateStatus(`Error: ${data.error}`, 'error');
            playBtn.disabled = false;
        }
    } catch (error) {
        console.error('Error speaking:', error);
        updateStatus('Connection error', 'error');
        playBtn.disabled = false;
    }
}

async function handleStop() {
    try {
        const response = await fetch('/api/stop', {
            method: 'POST'
        });

        const data = await response.json();

        if (data.success) {
            appState.isPlaying = false;
            appState.isPaused = false;
            updateStatus('Stopped', 'idle');
            playBtn.disabled = false;
        } else {
            updateStatus(`Error: ${data.error}`, 'error');
        }
    } catch (error) {
        console.error('Error stopping speech:', error);
        updateStatus('Connection error', 'error');
    }
}

async function handleTestVoice() {
    try {
        testVoiceBtn.disabled = true;
        updateStatus('Testing voice...', 'playing');

        const response = await fetch('/api/test-voices', {
            method: 'GET'
        });

        const data = await response.json();

        if (data.success) {
            setTimeout(() => {
                testVoiceBtn.disabled = false;
                updateStatus('Test complete', 'idle');
            }, 2000);
        } else {
            testVoiceBtn.disabled = false;
            updateStatus(`Error: ${data.error}`, 'error');
        }
    } catch (error) {
        console.error('Error testing voice:', error);
        testVoiceBtn.disabled = false;
        updateStatus('Connection error', 'error');
    }
}

// ============================================
// Slider Handlers
// ============================================

function updateVolumeDisplay() {
    const volume = parseInt(volumeSlider.value);
    volumeValue.textContent = `${volume}%`;
}

function updateRateDisplay() {
    const rate = parseInt(rateSlider.value);
    const speed = (rate / 150).toFixed(1);
    rateValue.textContent = `${speed}x`;
}

function updatePitchDisplay() {
    const pitch = parseFloat(pitchSlider.value);
    pitchValue.textContent = pitch.toFixed(1);
}

// ============================================
// Status Management
// ============================================

async function pollStatus() {
    try {
        const response = await fetch('/api/status');
        const data = await response.json();

        if (data.is_playing !== appState.isPlaying) {
            appState.isPlaying = data.is_playing;

            if (!data.is_playing) {
                // Stopped playing
                if (!appState.isPaused) {
                    updateStatus('Ready', 'idle');
                    playBtn.disabled = false;

                    // Show completion message briefly
                    if (data.current_text) {
                        statusMessage.textContent = 'Playback complete!';
                    }
                }
            }
        }
    } catch (error) {
        console.error('Error polling status:', error);
    }
}

function updateStatus(message, state = 'idle') {
    statusMessage.textContent = message;
    updateStatusUI(state);
}

function updateStatusUI(state) {
    statusIndicator.classList.remove('idle', 'playing', 'error');
    statusText.textContent = '';

    switch (state) {
        case 'playing':
            statusIndicator.classList.add('playing');
            statusText.textContent = 'Playing';
            stopBtn.disabled = false;
            break;
        case 'error':
            statusIndicator.classList.add('error');
            statusText.textContent = 'Error';
            stopBtn.disabled = true;
            break;
        case 'idle':
        default:
            statusIndicator.classList.add('idle');
            statusText.textContent = 'Idle';
            stopBtn.disabled = true;
    }
}

// ============================================
// Utility Functions
// ============================================

function formatLanguageName(lang) {
    const languages = {
        'en': 'English',
        'ur': 'Urdu',
        'en-US': 'English (US)',
        'en-GB': 'English (UK)',
        'en-AU': 'English (AU)',
        'en-IN': 'English (India)',
    };
    return languages[lang] || lang;
}

// Initialize on page load
console.log('🎙️ Offline TTS Tool Ready!');
