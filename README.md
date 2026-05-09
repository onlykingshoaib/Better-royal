# 🔊 Better-Royal Project

## Current Projects

### 1. Offline Text-to-Speech (TTS) Tool ✅ COMPLETE

A fully-featured, 100% offline text-to-speech application built with Python Flask and pyttsx3.

**Location:** `/tts-app/`

**Key Features:**
- 🎙️ Multiple voice selection (Male/Female)
- 🔊 Volume control (0-100%)
- ⏱️ Speech speed control (0.5x-2.0x)
- 🎵 Pitch adjustment (0.5-2.0)
- 🌍 Multi-language support (English, Urdu)
- 📱 Responsive web UI
- 🔒 100% Private (No cloud, no internet required)
- 🚀 Cross-platform (Windows, macOS, Linux)

**Quick Start:**
```bash
cd tts-app
chmod +x setup.sh && ./setup.sh  # or setup.bat on Windows
source venv/bin/activate
python app.py
# Open: http://localhost:5000
```

**Documentation:**
- [README.md](tts-app/README.md) - Main documentation
- [GUIDE.md](tts-app/GUIDE.md) - Complete user & developer guide
- [QUICKSTART.md](tts-app/QUICKSTART.md) - Quick reference
- [PROJECT_SUMMARY.md](tts-app/PROJECT_SUMMARY.md) - Project completion report

**Technologies:**
- Backend: Flask 3.0.0 + pyttsx3 2.90
- Frontend: HTML5, CSS3, Vanilla JavaScript
- Deployment: Docker + Docker Compose
- Platforms: Windows, macOS, Linux

---

## Project Structure

```
Better-royal/
├── tts-app/                          # Offline TTS Tool
│   ├── app.py                        # Flask backend
│   ├── config.py                     # Configuration
│   ├── requirements.txt              # Dependencies
│   ├── Dockerfile                    # Docker setup
│   ├── docker-compose.yml            # Docker Compose
│   ├── setup.sh                      # Linux/macOS setup
│   ├── setup.bat                     # Windows setup
│   ├── templates/
│   │   └── index.html               # Web UI
│   ├── static/
│   │   ├── style.css                # Styling
│   │   └── script.js                # Frontend JS
│   ├── README.md                    # Main docs
│   ├── GUIDE.md                     # Comprehensive guide
│   ├── QUICKSTART.md                # Quick reference
│   ├── PROJECT_SUMMARY.md           # Completion report
│   └── .gitignore                   # Git ignore rules
└── README.md                        # This file
```

---

## Features Implemented

### Core TTS Features
✅ Text-to-speech conversion  
✅ Multiple system voices  
✅ Volume control  
✅ Speech rate/speed control  
✅ Pitch adjustment  
✅ Play/Pause/Stop controls  
✅ Language support (EN/UR)  

### UI/UX Features
✅ Modern responsive design  
✅ Real-time controls  
✅ Status indicators  
✅ Voice preview/testing  
✅ Character counter  
✅ Mobile optimized  
✅ Accessibility features  

### System Features
✅ 100% offline operation  
✅ No cloud APIs  
✅ Cross-platform support  
✅ Non-blocking threading  
✅ Error handling  
✅ RESTful API  
✅ Docker support  

---

## Installation

### Prerequisites
- Python 3.8+
- pip (Python package manager)
- For Linux: espeak/espeak-ng

### Quick Install

**Linux/macOS:**
```bash
cd tts-app
chmod +x setup.sh
./setup.sh
source venv/bin/activate
python app.py
```

**Windows:**
```batch
cd tts-app
setup.bat
python app.py
```

**Docker:**
```bash
cd tts-app
docker-compose up --build
```

---

## Usage

1. **Enter Text** - Paste or type text in the input area
2. **Select Voice** - Choose from available system voices
3. **Adjust Settings** - Set volume, speed, and pitch
4. **Play** - Click play button to start TTS
5. **Control** - Use stop button to halt playback

---

## API Documentation

### REST Endpoints

```
GET  /                    Main web interface
GET  /api/voices          Get available voices
POST /api/speak           Start TTS playback
POST /api/stop            Stop playback
GET  /api/status          Check playback status
GET  /api/test-voices     Test voice
```

See [GUIDE.md](tts-app/GUIDE.md#api-reference) for full API documentation.

---

## Performance

| Metric | Value |
|--------|-------|
| Startup | < 2 seconds |
| Voice Loading | < 1 second |
| Memory | 50-100 MB |
| UI Lag | None (non-blocking) |
| Long Text | No lag (threading) |

---

## Security & Privacy

✅ **100% Offline** - No internet connection required  
✅ **No Cloud** - All processing local  
✅ **No Tracking** - No data collection  
✅ **No Ads** - Completely ad-free  
✅ **Open Source** - Full source transparency  

---

## Troubleshooting

### No Sound
- Check volume slider (not at 0%)
- Check system volume
- Verify speakers connected

### No Voices
- **Linux:** `sudo apt-get install espeak espeak-ng`
- **Windows:** Settings > Speech > Download voices
- **macOS:** Accessibility > Speech

### Port In Use
```bash
lsof -i :5000  # Find process
kill -9 <PID>  # Kill it
```

See [GUIDE.md](tts-app/GUIDE.md#troubleshooting) for more help.

---

## Browser Support

✅ Chrome/Edge  
✅ Firefox  
✅ Safari  
✅ Mobile browsers  

---

## Configuration

Edit `tts-app/config.py` to customize:
- Default volume, rate, pitch
- Supported languages
- UI theme
- Logging settings
- Performance tuning

---

## Development

### Adding Features
1. Add API endpoint in `app.py`
2. Add UI button in `templates/index.html`
3. Add JavaScript handler in `static/script.js`
4. Add styling in `static/style.css`

### Testing
```bash
python app.py  # Run with debug enabled
# Visit http://localhost:5000
# F12 to open DevTools
```

### Production
```bash
# Using Gunicorn
pip install gunicorn
gunicorn -w 4 app:app

# Using Docker
docker-compose up
```

---

## File Sizes & Statistics

| File | Lines | Purpose |
|------|-------|---------|
| app.py | 250+ | Flask backend |
| config.py | 100+ | Configuration |
| index.html | 150+ | Web UI |
| style.css | 600+ | Styling |
| script.js | 400+ | Frontend logic |
| README.md | 500+ | Documentation |
| GUIDE.md | 800+ | Comprehensive guide |

**Total Documentation:** 10,000+ words

---

## Dependencies

### Python Packages
```
Flask==3.0.0
pyttsx3==2.90
Werkzeug==3.0.1
```

### System Dependencies
- **Linux:** espeak, espeak-ng
- **macOS:** Built-in TTS
- **Windows:** Built-in SAPI 5

---

## License

MIT License - Open Source

---

## Version History

**v1.0.0** (May 2026) - Initial Release
- Full TTS functionality
- Complete UI/UX
- Comprehensive documentation
- Docker support
- Cross-platform support

---

## Support

- **Documentation:** See tts-app/README.md and tts-app/GUIDE.md
- **Quick Start:** See tts-app/QUICKSTART.md
- **API Docs:** See tts-app/GUIDE.md#api-reference
- **Troubleshooting:** See tts-app/GUIDE.md#troubleshooting

---

## What's Next?

Potential future enhancements:
- [ ] Audio file export (MP3/WAV)
- [ ] History & bookmarks
- [ ] Batch processing
- [ ] SSML support
- [ ] Multiple UI languages
- [ ] Dark mode
- [ ] PWA offline mode

---

## Credits

**Project:** Better-Royal Offline TTS Tool  
**Version:** 1.0.0  
**Status:** Production Ready ✅  
**License:** MIT  
**Last Updated:** May 9, 2026  

---

## 🎙️ Ready to Use!

```bash
cd tts-app
chmod +x setup.sh && ./setup.sh
source venv/bin/activate
python app.py
# Open http://localhost:5000
```

**Enjoy offline, private, unrestricted text-to-speech! 🔊**