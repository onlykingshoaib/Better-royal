"""
Configuration settings for Offline TTS Tool
Modify these settings to customize the application behavior
"""

# Flask Configuration
FLASK_DEBUG = True
FLASK_HOST = '0.0.0.0'
FLASK_PORT = 5000
SECRET_KEY = 'your-secret-key-change-in-production'

# TTS Engine Configuration
TTS_ENGINE = 'pyttsx3'  # Currently supports: pyttsx3

# Default Audio Settings
TTS_DEFAULT_VOLUME = 100  # 0-100
TTS_DEFAULT_RATE = 150    # 75-300 (words per minute)
TTS_DEFAULT_PITCH = 1.0   # 0.5-2.0
TTS_DEFAULT_LANGUAGE = 'en'

# Audio Quality Settings
AUDIO_SAMPLE_RATE = 44100  # Hz
AUDIO_CHANNELS = 2          # Mono=1, Stereo=2
AUDIO_BIT_WIDTH = 16        # Bits per sample (16 or 32)

# Threading Configuration
MAX_CONCURRENT_SPEAKS = 1   # Number of simultaneous TTS operations
REQUEST_TIMEOUT = 60        # Seconds

# Supported Languages
SUPPORTED_LANGUAGES = {
    'en': 'English',
    'ur': 'Urdu',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'zh': 'Chinese',
    'ja': 'Japanese'
}

# Language Codes for Voice Selection
LANGUAGE_CODES = {
    'English': 'en-US',
    'English (UK)': 'en-GB',
    'Urdu': 'ur-PK',
    'Spanish': 'es-ES',
    'French': 'fr-FR',
    'German': 'de-DE',
    'Arabic': 'ar-SA',
}

# UI Configuration
UI_THEME = 'modern'  # Options: 'modern', 'dark', 'light'
UI_LANGUAGE = 'en'   # UI language (future feature)
UI_CUSTOM_COLORS = {
    'primary': '#6366f1',
    'secondary': '#8b5cf6',
    'danger': '#ef4444',
    'success': '#10b981'
}

# Logging Configuration
LOG_LEVEL = 'INFO'  # DEBUG, INFO, WARNING, ERROR, CRITICAL
LOG_FILE = 'tts_app.log'
LOG_MAX_SIZE = 10485760  # 10MB
LOG_BACKUP_COUNT = 5

# Performance Settings
CACHE_VOICES = True         # Cache voice list
CACHE_DURATION = 3600       # 1 hour
USE_THREADING = True        # Use threading for TTS (recommended)
MAX_TEXT_LENGTH = 5000      # Maximum characters per request

# Security Settings
ENABLE_CORS = False         # Cross-Origin Resource Sharing
ALLOWED_ORIGINS = ['localhost:5000']
RATE_LIMIT = 100            # Requests per minute

# Feature Flags
FEATURES = {
    'voice_testing': True,
    'batch_processing': False,
    'audio_export': False,
    'history': False,
    'bookmarks': False,
    'ssml_support': False,
    'dark_mode': False
}

# Environment-specific settings
ENVIRONMENT = 'development'  # development, production, testing
