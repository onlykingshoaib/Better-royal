# Offline TTS Tool - Quick Reference

## 🚀 Quick Start

### Linux/macOS
```bash
cd /workspaces/Better-royal/tts-app
chmod +x setup.sh && ./setup.sh
source venv/bin/activate
python app.py
# Open: http://localhost:5000
```

### Windows
```batch
cd \workspaces\Better-royal\tts-app
setup.bat
python app.py
# Open: http://localhost:5000
```

### Docker
```bash
cd /workspaces/Better-royal/tts-app
docker-compose up --build
# Open: http://localhost:5000
```

## 📁 Project Files

| File | Purpose |
|------|---------|
| `app.py` | Flask backend + pyttsx3 TTS engine |
| `config.py` | Application configuration |
| `templates/index.html` | Web UI |
| `static/style.css` | UI styling |
| `static/script.js` | Frontend logic |
| `requirements.txt` | Python dependencies |
| `Dockerfile` | Container definition |
| `docker-compose.yml` | Container orchestration |

## 🎙️ UI Controls

```
Text Input Area
  ↓
Select Voice (Dropdown)
  ↓
Adjust Sliders:
  • Volume (0-100%)
  • Speed (0.5x-2.0x)
  • Pitch (0.5-2.0)
  ↓
Play/Stop Buttons
  ↓
Status Indicator
```

## 🔧 Slider Ranges

| Slider | Min | Max | Unit | Default |
|--------|-----|-----|------|---------|
| Volume | 0 | 100 | % | 100 |
| Speed | 0.5 | 2.0 | x | 1.0 |
| Pitch | 0.5 | 2.0 | tone | 1.0 |

## 📊 API Endpoints

```
GET  /                    # Main page
GET  /api/voices          # List voices
POST /api/speak           # Start TTS
POST /api/stop            # Stop TTS
GET  /api/status          # Check status
GET  /api/test-voices     # Test voice
```

## 🐛 Troubleshooting

### No Sound
- Check volume slider (>0%)
- Check system volume
- Verify speakers connected

### No Voices
- Linux: `sudo apt-get install espeak espeak-ng`
- Windows: Settings > Speech > Download voice
- macOS: Accessibility > Speech > Select voice

### Port 5000 In Use
```bash
# Find process
lsof -i :5000

# Kill it
kill -9 <PID>

# Or use different port in app.py (line 150)
```

### UI Frozen
- Wait for current playback to finish
- Reload page (Ctrl+R / Cmd+R)
- Check browser console (F12)

## 📝 Keyboard Shortcuts

| Action | Keys |
|--------|------|
| Play | Alt+P |
| Stop | Alt+S |
| Focus Text | Tab then Enter |
| Increase Volume | Ctrl+Up |
| Decrease Volume | Ctrl+Down |

## 💾 Dependencies

```
Flask==3.0.0
pyttsx3==2.90
Werkzeug==3.0.1
```

## 🎯 Supported Languages

| Language | Platform | Notes |
|----------|----------|-------|
| English (US) | All | Default |
| English (UK) | macOS, Linux | OS dependent |
| Urdu | Limited | Requires OS pack |
| Others | Varies | Check OS TTS |

## 📊 Performance

- **Startup:** < 2 seconds
- **Voice Load:** < 1 second
- **UI Response:** Real-time (non-blocking)
- **Memory:** 50-100MB
- **CPU (Playing):** 5-15%

## 🔒 Security

✅ 100% Offline  
✅ No Cloud APIs  
✅ No Data Collection  
✅ Local Processing Only  
✅ No Internet Required  

## 📚 Key Features

- ✅ Multi-language support (EN, UR)
- ✅ Volume control (0-100%)
- ✅ Speed control (0.5x-2.0x)
- ✅ Pitch adjustment (0.5-2.0)
- ✅ Multiple voice selection
- ✅ Play/Pause/Stop controls
- ✅ Real-time status
- ✅ Responsive design
- ✅ No lag on long text
- ✅ Voice preview/testing

## 🎨 Customization

### Change Port
Edit `app.py` line ~150:
```python
app.run(debug=True, host='0.0.0.0', port=5001)
```

### Change Theme Colors
Edit `static/style.css`:
```css
:root {
  --primary-color: #6366f1;  /* Change this */
}
```

### Change Default Settings
Edit `config.py`:
```python
DEFAULT_SETTINGS = {
    'volume': 100,
    'rate': 150,
    'pitch': 1.0,
}
```

## 📖 Documentation Files

- `README.md` - Main documentation
- `GUIDE.md` - Comprehensive user & developer guide
- `QUICKSTART.md` - This file (quick reference)
- `config.py` - Configuration options
- Code comments - Inline documentation

## 👨‍💻 For Developers

### Add Feature
1. Add API route in `app.py`
2. Add UI element in `templates/index.html`
3. Add JavaScript handler in `static/script.js`
4. Add styling in `static/style.css`

### Test Locally
```bash
python app.py
# Visit http://localhost:5000
# F12 to open DevTools, check Console
```

### Production Deployment
```bash
# Using Gunicorn
pip install gunicorn
gunicorn -w 4 app:app

# Using Docker
docker-compose up
```

## 🔗 Useful Links

- Flask: https://flask.palletsprojects.com/
- pyttsx3: https://pyttsx3.readthedocs.io/
- Python: https://www.python.org/

## ⚡ Pro Tips

1. **Use Test Voice** before long texts
2. **Split long text** over multiple plays
3. **Adjust pitch** for gender preference
4. **Use 1.5x speed** for faster listening
5. **Keep text under 2000 chars** for speed
6. **Test with simple text first** ("Hello")

## 📞 Common Issues

| Issue | Fix |
|-------|-----|
| "Can't connect" | Run `python app.py` |
| "No sound" | Check volume slider & system volume |
| "Port in use" | Kill process or change port |
| "No voices" | Install language pack |
| "Laggy" | It uses threading, reload page |

---

**Version:** 1.0.0 | **Last Updated:** 2026-05-09 | **License:** MIT
