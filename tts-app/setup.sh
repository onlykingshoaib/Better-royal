#!/bin/bash

# ============================================
# Offline TTS Tool - Setup Script
# ============================================

echo "🎙️ Setting up Offline TTS Tool..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Python installation
echo -n "Checking Python installation... "
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}✗${NC}"
    echo "Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi
PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
echo -e "${GREEN}✓${NC} (Python $PYTHON_VERSION)"

# Check pip installation
echo -n "Checking pip installation... "
if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}✗${NC}"
    echo "pip3 is not installed. Please install pip."
    exit 1
fi
echo -e "${GREEN}✓${NC}"

# Install system dependencies based on OS
echo ""
echo "Installing system dependencies..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected Linux system"
    echo "Installing espeak and related tools..."
    sudo apt-get update
    sudo apt-get install -y espeak espeak-ng libsndfile1
    echo -e "${GREEN}✓${NC} Linux dependencies installed"

elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS system"
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "No additional dependencies needed for macOS"
    echo -e "${GREEN}✓${NC} macOS ready"

elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Detected Windows system"
    echo "No system dependencies needed (uses SAPI 5)"
    echo -e "${GREEN}✓${NC} Windows ready"
else
    echo "Unknown OS: $OSTYPE"
fi

# Create virtual environment
echo ""
echo -n "Creating Python virtual environment... "

if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}(already exists)${NC}"
fi

# Activate virtual environment
echo -n "Activating virtual environment... "
source venv/bin/activate
echo -e "${GREEN}✓${NC}"

# Upgrade pip
echo -n "Upgrading pip... "
pip install --upgrade pip > /dev/null 2>&1
echo -e "${GREEN}✓${NC}"

# Install Python dependencies
echo ""
echo "Installing Python dependencies from requirements.txt..."
pip install -r requirements.txt

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} All dependencies installed successfully"
else
    echo -e "${RED}✗${NC} Failed to install dependencies"
    exit 1
fi

# Verify installation
echo ""
echo "Verifying installation..."
python3 -c "import flask; print(f'Flask {flask.__version__}')" 2>/dev/null
python3 -c "import pyttsx3; print('pyttsx3 installed')" 2>/dev/null

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo ""
    echo "Creating .env file..."
    cat > .env << EOF
# Offline TTS Tool Environment Variables
FLASK_ENV=development
FLASK_DEBUG=True
FLASK_HOST=0.0.0.0
FLASK_PORT=5000
EOF
    echo -e "${GREEN}✓${NC} .env file created"
fi

# Summary
echo ""
echo -e "${GREEN}✓ Setup completed successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Activate the virtual environment (if not already activated):"
echo "   source venv/bin/activate"
echo ""
echo "2. Run the application:"
echo "   python app.py"
echo ""
echo "3. Open your browser and navigate to:"
echo "   http://localhost:5000"
echo ""
echo "🎙️ Happy speaking!"
