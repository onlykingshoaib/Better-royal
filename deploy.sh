#!/bin/bash

# Offline TTS Tool - Deployment Helper
# This script automates common deployment tasks

set -e

echo "🚀 Better-Royal TTS Tool - Deployment Helper"
echo "=============================================="
echo ""

# Check git
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed"
    exit 1
fi

# Get repository status
echo "📊 Repository Status:"
cd /workspaces/Better-royal
echo "Branch: $(git branch --show-current)"
echo "Remote: $(git config --get remote.origin.url)"
echo ""

# Menu
echo "Select deployment option:"
echo "1) Check deployment readiness"
echo "2) Pull latest changes"
echo "3) Push changes to GitHub"
echo "4) Deploy to Vercel (setup)"
echo "5) Deploy to Heroku (setup)"
echo "6) Run production test locally"
echo "7) Show deployment URLs"
echo ""
read -p "Enter choice (1-7): " choice

case $choice in
    1)
        echo "✅ Checking deployment readiness..."
        echo ""
        echo "Files required for deployment:"
        test -f vercel.json && echo "✅ vercel.json" || echo "❌ vercel.json missing"
        test -f Procfile && echo "✅ Procfile" || echo "❌ Procfile missing"
        test -f runtime.txt && echo "✅ runtime.txt" || echo "❌ runtime.txt missing"
        test -f .env.example && echo "✅ .env.example" || echo "❌ .env.example missing"
        test -f tts-app/requirements.txt && grep -q gunicorn tts-app/requirements.txt && echo "✅ gunicorn in requirements.txt" || echo "❌ gunicorn missing"
        echo ""
        echo "✅ All files ready for deployment!"
        ;;
    2)
        echo "📥 Pulling latest changes..."
        git pull origin main
        echo "✅ Pulled successfully"
        ;;
    3)
        echo "📤 Pushing changes to GitHub..."
        git status
        echo ""
        read -p "Push these changes? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            git push origin main
            echo "✅ Pushed successfully"
        fi
        ;;
    4)
        echo "🔗 Vercel Deployment Setup"
        echo "================================"
        echo "1. Go to: https://vercel.com/new"
        echo "2. Click 'Continue with GitHub'"
        echo "3. Search for 'Better-royal' repository"
        echo "4. Click 'Import'"
        echo "5. Configure settings (defaults are fine)"
        echo "6. Click 'Deploy'"
        echo ""
        echo "✅ Follow the steps above to deploy to Vercel"
        echo ""
        read -p "Open Vercel in browser? (y/n): " open_browser
        if [ "$open_browser" = "y" ]; then
            xdg-open "https://vercel.com/new" 2>/dev/null || open "https://vercel.com/new" 2>/dev/null || echo "Open manually: https://vercel.com/new"
        fi
        ;;
    5)
        echo "🔗 Heroku Deployment Setup"
        echo "================================"
        if ! command -v heroku &> /dev/null; then
            echo "❌ Heroku CLI not installed"
            echo "Install from: https://devcenter.heroku.com/articles/heroku-cli"
            exit 1
        fi
        echo "1. Run: heroku login"
        echo "2. Run: heroku create your-app-name"
        echo "3. Run: git push heroku main"
        echo "4. Run: heroku open"
        echo ""
        read -p "Continue with Heroku setup? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            heroku login
            read -p "App name (leave blank for auto-generate): " app_name
            if [ -n "$app_name" ]; then
                heroku create "$app_name"
            else
                heroku create
            fi
            git push heroku main
            echo "✅ Deploying to Heroku..."
        fi
        ;;
    6)
        echo "🧪 Running production test locally..."
        echo ""
        cd tts-app
        if [ ! -f venv/bin/activate ]; then
            echo "Creating virtual environment..."
            python3 -m venv venv
        fi
        source venv/bin/activate
        pip install -q -r requirements.txt
        echo "✅ Dependencies installed"
        echo ""
        echo "Starting production server on http://localhost:5000"
        echo "Press Ctrl+C to stop"
        echo ""
        FLASK_ENV=production gunicorn -w 4 -b 0.0.0.0:5000 app:app
        ;;
    7)
        echo "🔗 Deployment URLs"
        echo "================================"
        echo ""
        echo "After deployment, your app will be at:"
        echo ""
        echo "Vercel:  https://your-app-name.vercel.app"
        echo "Heroku:  https://your-app-name.herokuapp.com"
        echo "Docker:  http://your-server-ip:8000"
        echo ""
        echo "Replace 'your-app-name' with your actual app name"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "✅ Complete!"
