# 📚 Offline TTS Tool - Complete User & Developer Guide

## Table of Contents
1. [Quick Start](#quick-start)
2. [Installation](#installation)
3. [Usage Guide](#usage-guide)
4. [Troubleshooting](#troubleshooting)
5. [Developer Guide](#developer-guide)
6. [API Reference](#api-reference)

---

## Quick Start

### For Linux/macOS Users

```bash
# 1. Navigate to the project
cd /workspaces/Better-royal/tts-app

# 2. Run setup script
chmod +x setup.sh
./setup.sh

# 3. Activate virtual environment
source venv/bin/activate

# 4. Start the application
python app.py

# 5. Open browser to http://localhost:5000
```

### For Windows Users

```batch
# 1. Navigate to the project
cd \workspaces\Better-royal\tts-app

# 2. Run setup script (double-click or run in terminal)
setup.bat

# 3. The virtual environment is automatically activated

# 4. Start the application
python app.py

# 5. Open browser to http://localhost:5000
```

### Using Docker

```bash
# Build and run with Docker Compose
cd /workspaces/Better-royal/tts-app
docker-compose up --build

# Visit http://localhost:5000
```

---

## Installation

### Prerequisites

| Platform | Requirements |
|----------|--------------|
| **All Platforms** | Python 3.8+, pip |
| **Linux** | espeak, espeak-ng |
| **macOS** | None (uses native TTS) |
| **Windows** | None (uses SAPI 5) |

### Step-by-Step Installation

#### 1. Python Installation

**Windows:**
- Download from https://www.python.org/downloads/
- Run installer, ✅ check "Add Python to PATH"
- Click "Install Now"

**macOS:**
```bash
# Using Homebrew (recommended)
brew install python3

# Or download from https://www.python.org/downloads/
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install python3 python3-pip python3-venv
```

#### 2. Clone/Navigate to Project

```bash
cd /workspaces/Better-royal/tts-app
```

#### 3. Create Virtual Environment

**Linux/macOS:**
```bash
python3 -m venv venv
source venv/bin/activate
```

**Windows:**
```batch
python -m venv venv
venv\Scripts\activate
```

#### 4. Install Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

#### 5. Install System Dependencies (Linux only)

```bash
sudo apt-get install espeak espeak-ng libsndfile1
```

#### 6. Run Application

```bash
python app.py
```

You should see:
```
Available Voices:
  - Microsoft Zira Desktop
  - Microsoft David Desktop
 * Running on http://0.0.0.0:5000
```

---

## Usage Guide

### Basic Workflow

1. **Enter Text**
   - Click the text input area
   - Paste or type content (English/Urdu supported)
   - Text length shows character count

2. **Select Voice**
   - Open the voice dropdown
   - Choose between Male/Female voices
   - Different voices available per OS

3. **Adjust Settings**
   - **Volume**: 0-100% (0 = silent, 100 = maximum)
   - **Speed**: 0.5x - 2.0x (0.5 = half speed, 2.0 = double speed)
   - **Pitch**: 0.5 - 2.0 (0.5 = low tone, 2.0 = high tone)

4. **Test Voice** (Optional)
   - Click "Test Voice" button
   - Hear sample with selected voice
   - Useful before processing long texts

5. **Play**
   - Click "▶ Play" button
   - Status shows "Playing" with character count
   - Stop button becomes available

6. **Manage Playback**
   - **Play**: Start TTS of entered text
   - **Stop**: Pause/cancel current playback
   - Status indicator shows current state (Idle/Playing)

### Settings Explanations

#### Volume Slider
- **0%**: Silent (no audio)
- **25%**: Quiet background level
- **50%**: Normal comfortable level
- **75%**: Loud and clear
- **100%**: Maximum volume

#### Speed Slider
- **0.5x**: Very slow, good for:
  - Language learners
  - Complex technical content
  - Listening for detail
  
- **1.0x**: Normal speech rate (~150 words/minute)
  
- **1.5x**: Faster, good for:
  - Familiar content
  - News/articles skimming
  
- **2.0x**: Very fast, good for:
  - Quick review
  - Re-reading familiar content

#### Pitch Slider
- **0.5**: Lower tone
  - More authoritative
  - Better for male narration
  - Deeper voice
  
- **1.0**: Normal pitch (default)
  
- **1.5+**: Higher tone
  - More expressive
  - Better for female narration
  - Sounds friendlier

### Voice Selection Tips

**Choose Male Voice When:**
- Narrating technical content
- Want authoritative tone
- Prefer deeper voice

**Choose Female Voice When:**
- Narrating stories/creative content
- Want friendly tone
- Prefer higher-pitched voice

**Test Different Voices:**
- Each voice has different quality
- Some better for certain languages
- Use "Test Voice" button to preview

### Text Input Tips

**Maximum Length:** 5000 characters per request

**Supported Content:**
- English text (any dialect)
- Urdu text (if OS supports)
- Numbers (reads as digits)
- Punctuation (affects pacing)

**Tips:**
- Remove extra spaces for clarity
- Long paragraphs work fine
- Use short sentences for better clarity
- Add punctuation for natural pauses

---

## Troubleshooting

### Issues & Solutions

#### Issue: "No voices available"

**Windows:**
1. Go to Settings > Time & Language
2. Click "Speech Recognition"
3. Click "Manage voices"
4. Download at least one voice

**macOS:**
1. System Preferences > Accessibility > Speech
2. Verify "Speak text" is enabled
3. Check available voices in dropdown

**Linux:**
```bash
# Install espeak
sudo apt-get install espeak espeak-ng

# Verify installation
espeak --voices
```

#### Issue: "No sound/audio not playing"

**Checklist:**
1. ✅ Volume slider NOT at 0%
2. ✅ System volume turned up (not muted)
3. ✅ Speakers/headphones connected
4. ✅ Try different voice
5. ✅ Test with simple text ("Hello")

**Solution:**
```bash
# Check system audio (Linux)
amixer get Master

# Check system audio (macOS)
osascript -e 'output volume of (get volume settings)'
```

#### Issue: "Application laggy/freezing"

**Cause:** Processing long text (> 2000 characters)

**Solution:**
- Application uses threading (shouldn't freeze UI)
- Wait for current playback to complete
- Reload page if UI becomes unresponsive
- Try with shorter text first

#### Issue: "Cannot connect to server"

**Error:** "Connection error" messages

**Solutions:**
1. Verify server is running:
   ```bash
   # Should show: "Running on http://..."
   python app.py
   ```

2. Check port is not in use:
   ```bash
   # Linux/macOS
   lsof -i :5000
   
   # Windows
   netstat -ano | findstr :5000
   ```

3. Kill existing process:
   ```bash
   # Linux/macOS
   kill -9 <PID>
   
   # Windows
   taskkill /PID <PID> /F
   ```

4. Use different port:
   - Edit `app.py` line 150:
   ```python
   app.run(debug=True, host='0.0.0.0', port=5001)
   ```

#### Issue: "Port 5000 already in use"

**Solution:**
```bash
# Find what's using port 5000
lsof -i :5000

# Kill the process (macOS/Linux)
kill -9 <process_id>

# Or use different port in app.py
```

#### Issue: "Urdu text not working"

**Note:** Urdu support depends on OS TTS engine

**Windows:**
- Urdu support limited
- May need third-party TTS engine

**macOS:**
- Built-in support for many languages
- Check System Preferences > Accessibility > Speech

**Linux:**
- Install Urdu language pack:
```bash
sudo apt-get install language-pack-ur
sudo apt-get install espeak-ng-hindi  # or Arabic alternatives
```

#### Issue: "High CPU/Memory usage"

**Cause:** Possible long text processing

**Solutions:**
1. Keep text under 2000 characters
2. Close unnecessary applications
3. Restart browser if needed
4. Check system resources:
   ```bash
   top  # Linux/macOS
   tasklist  # Windows
   ```

### Common Error Messages

| Error | Meaning | Solution |
|-------|---------|----------|
| "Text cannot be empty" | No text entered | Type or paste text in input |
| "Already speaking" | TTS already running | Click Stop, then Play again |
| "ConnectionError" | Can't reach server | Check if `python app.py` is running |
| "Maximum text exceeded" | Text too long | Split into smaller pieces |

---

## Developer Guide

### Project Architecture

```
tts-app/
├── app.py                 # Flask backend + pyttsx3 integration
├── config.py              # Configuration settings
├── requirements.txt       # Python dependencies
├── Dockerfile             # Docker container setup
├── docker-compose.yml     # Docker orchestration
├── setup.sh              # Linux/macOS setup script
├── setup.bat             # Windows setup script
├── templates/
│   └── index.html        # Main UI template
├── static/
│   ├── style.css         # UI styling
│   └── script.js         # Frontend logic
└── README.md             # Documentation
```

### Backend Architecture

#### Flask Routes

```python
GET  /                    # Serve HTML UI
GET  /api/voices          # Get available voices
POST /api/speak           # Start TTS playback
POST /api/stop            # Stop TTS
GET  /api/status          # Get current status
GET  /api/test-voices     # Test voice
```

#### Threading Model

```python
# Main thread: Flask server (handles requests)
# Worker thread: pyttsx3 TTS engine (non-blocking)
# Status polling: JavaScript (500ms intervals)
```

#### State Management

```python
tts_state = {
    'is_playing': False,
    'is_paused': False,
    'current_text': '',
    'lock': threading.Lock()  # Thread safety
}
```

### Frontend Architecture

#### Component Structure

```
UI (index.html)
├── Text Input Section
│   └── Textarea + Character counter
├── Voice Selection
│   ├── Dropdown menu
│   └── Test button
├── Controls
│   ├── Play button
│   └── Stop button
├── Sliders
│   ├── Volume (0-100%)
│   ├── Rate (0.5x-2.0x)
│   └── Pitch (0.5-2.0)
└── Status Display
    ├── Status message
    └── Indicator (Idle/Playing/Error)
```

#### JavaScript Event Flow

```
User Action → Event Listener → API Call → Server Processing → Status Update → UI Render
```

### Extending the Application

#### Adding New Features

1. **Add API Endpoint** (in `app.py`):
```python
@app.route('/api/new-feature', methods=['POST'])
def new_feature():
    # Handle request
    return jsonify({'success': True})
```

2. **Update Frontend** (in `static/script.js`):
```javascript
async function handleNewFeature() {
    const response = await fetch('/api/new-feature', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
}
```

3. **Update UI** (in `templates/index.html`):
```html
<button id="newFeatureBtn">New Feature</button>
```

4. **Style it** (in `static/style.css`):
```css
#newFeatureBtn {
    /* your styles */
}
```

#### Adding Language Support

1. Ensure OS has language pack installed
2. Add to `SUPPORTED_LANGUAGES` in `config.py`
3. Add language option to voice dropdown in HTML
4. Update backend to handle language parameter

#### Database Integration

To add persistence (bookmarks, history):

```bash
pip install flask-sqlalchemy
```

```python
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy(app)

class History(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String(5000))
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
```

### Performance Optimization

#### Current Optimizations
- ✅ Threading for non-blocking TTS
- ✅ Voice caching
- ✅ Efficient API responses
- ✅ CSS minification ready
- ✅ JS optimization ready

#### Future Optimization Opportunities
- [ ] Audio file caching
- [ ] Request debouncing
- [ ] Gzip compression
- [ ] Lazy loading
- [ ] Service workers
- [ ] Offline mode

### Testing

#### Manual Testing Checklist

- [ ] Text input accepts content
- [ ] Voice dropdown populates
- [ ] Test voice button works
- [ ] Play button starts audio
- [ ] Stop button halts audio
- [ ] Volume slider changes volume
- [ ] Rate slider changes speed
- [ ] Pitch slider changes tone
- [ ] Status updates in real-time
- [ ] Multiple languages work
- [ ] Long text doesn't freeze UI
- [ ] Clear error messages on failures

#### Unit Testing Example

```python
import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    return app.test_client()

def test_voices_endpoint(client):
    response = client.get('/api/voices')
    assert response.status_code == 200
    assert 'voices' in response.json

def test_speak_with_empty_text(client):
    response = client.post('/api/speak', json={'text': ''})
    assert response.status_code == 400
```

---

## API Reference

### Base URL
```
http://localhost:5000/api
```

### Authentication
None required (local application)

### Rate Limiting
No rate limiting (local development)

### Response Format
All endpoints return JSON

### Endpoints

#### 1. Get Available Voices

**Request:**
```http
GET /api/voices
```

**Response:**
```json
{
  "success": true,
  "voices": [
    {
      "id": 0,
      "name": "Microsoft Zira Desktop",
      "gender": "Female",
      "lang": "en"
    }
  ],
  "default_language": "en"
}
```

#### 2. Speak Text

**Request:**
```http
POST /api/speak
Content-Type: application/json

{
  "text": "Hello, world!",
  "volume": 100,
  "rate": 150,
  "pitch": 1.0,
  "voice_id": 0,
  "language": "en"
}
```

**Parameters:**
- `text` (string, required): Text to speak
- `volume` (integer, 0-100): Volume level
- `rate` (integer, 50-300): Speech rate in WPM
- `pitch` (float, 0.5-2.0): Voice pitch
- `voice_id` (integer): Index of voice
- `language` (string): Language code

**Response:**
```json
{
  "success": true,
  "message": "Speaking...",
  "text_length": 13
}
```

**Error Response:**
```json
{
  "success": false,
  "error": "Text cannot be empty"
}
```

#### 3. Stop Speaking

**Request:**
```http
POST /api/stop
```

**Response:**
```json
{
  "success": true,
  "message": "Speech stopped"
}
```

#### 4. Get Status

**Request:**
```http
GET /api/status
```

**Response:**
```json
{
  "is_playing": false,
  "is_paused": false,
  "current_text": ""
}
```

#### 5. Test Voices

**Request:**
```http
GET /api/test-voices
```

**Response:**
```json
{
  "success": true,
  "message": "Testing voice..."
}
```

### Error Codes

| Code | Status | Meaning |
|------|--------|---------|
| 200 | OK | Successful request |
| 400 | Bad Request | Invalid input data |
| 500 | Server Error | Server processing error |

### Example Usage

#### JavaScript Fetch Example
```javascript
const response = await fetch('/api/speak', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    text: 'Hello world',
    volume: 100,
    rate: 150,
    pitch: 1.0,
    voice_id: 0
  })
});

const data = await response.json();
if (data.success) {
  console.log('Speaking...');
}
```

#### cURL Example
```bash
curl -X POST http://localhost:5000/api/speak \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Hello world",
    "volume": 100,
    "rate": 150,
    "pitch": 1.0,
    "voice_id": 0
  }'
```

---

## Deployment

### Local Development
```bash
python app.py  # Debug mode on
```

### Production with Gunicorn
```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Docker Production
```bash
docker-compose up --build
```

### Cloud Deployment
- Heroku, Azure, AWS, Google Cloud all support Flask
- Modify for 100% offline mode (no audio export)
- Ensure system dependencies installed

---

## Support & Resources

- **Flask Documentation**: https://flask.palletsprojects.com/
- **pyttsx3 Documentation**: https://pyttsx3.readthedocs.io/
- **Python Documentation**: https://docs.python.org/3/
- **MDN Web Docs**: https://developer.mozilla.org/

---

**Version:** 1.0.0  
**Last Updated:** 2026-05-09  
**Author:** Offline TTS Tool Team  
**License:** MIT
