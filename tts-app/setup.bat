@echo off
REM ============================================
REM Offline TTS Tool - Windows Setup Script
REM ============================================

echo.
echo ^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=
echo Offline TTS Tool - Windows Setup
echo ^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=
echo.

REM Check Python installation
echo Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH
    echo Please install Python 3.8 or higher from https://www.python.org
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo [OK] Python %PYTHON_VERSION% found

REM Check pip installation
echo Checking pip installation...
pip --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] pip is not installed
    pause
    exit /b 1
)
echo [OK] pip is installed

REM Create virtual environment
echo.
echo Creating virtual environment...
if exist venv (
    echo [INFO] Virtual environment already exists
) else (
    python -m venv venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat
if errorlevel 1 (
    echo [ERROR] Failed to activate virtual environment
    pause
    exit /b 1
)
echo [OK] Virtual environment activated

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip >nul 2>&1
echo [OK] pip upgraded

REM Install dependencies
echo.
echo Installing Python dependencies from requirements.txt...
pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] All dependencies installed successfully

REM Verify installation
echo.
echo Verifying installation...
python -c "import flask; print(f'Flask installed')" 2>nul
python -c "import pyttsx3; print(f'pyttsx3 installed')" 2>nul

REM Create .env file if it doesn't exist
if not exist .env (
    echo.
    echo Creating .env file...
    (
        echo # Offline TTS Tool Environment Variables
        echo FLASK_ENV=development
        echo FLASK_DEBUG=True
        echo FLASK_HOST=0.0.0.0
        echo FLASK_PORT=5000
    ) > .env
    echo [OK] .env file created
)

REM Summary
echo.
echo ^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=
echo Setup completed successfully!
echo ^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=
echo.
echo Next steps:
echo.
echo 1. The virtual environment is already activated
echo.
echo 2. Run the application:
echo    python app.py
echo.
echo 3. Open your browser and navigate to:
echo    http://localhost:5000
echo.
echo Happy speaking!
echo.
pause
