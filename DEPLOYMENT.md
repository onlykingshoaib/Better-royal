# 🚀 Offline TTS Tool - Deployment Guide

## ✅ Production Configuration Complete

All files have been committed to GitHub and are ready for production deployment!

### GitHub Repository
📍 **Repository:** https://github.com/onlykingshoaib/Better-royal  
📍 **Branch:** main  
✅ **Status:** All changes pushed successfully

---

## 🎯 Deployment Options

### **Option 1: Deploy to Vercel (Recommended - Fastest)**

**Advantages:**
- Serverless deployment
- Automatic HTTPS
- Free tier available
- Auto-deploys on git push
- Global CDN

**Steps:**

1. **Go to Vercel Dashboard**
   - Visit https://vercel.com/new
   - Click "New Project"

2. **Import GitHub Repository**
   - Select "GitHub" as source
   - Search for "Better-royal"
   - Click "Import"

3. **Configure Project**
   - **Project Name:** `better-royal` (or your choice)
   - **Framework Preset:** Python
   - **Root Directory:** `./` (default)

4. **Environment Variables** (Optional)
   - Click "Environment Variables"
   - Add:
     ```
     FLASK_ENV=production
     FLASK_DEBUG=False
     ```

5. **Deploy**
   - Click "Deploy"
   - Wait for deployment (usually < 2 minutes)
   - You'll get a live URL!

**Live URL Format:** `https://better-royal-xxxx.vercel.app`

---

### **Option 2: Deploy to Heroku**

**Advantages:**
- Simple deployment
- Free tier available
- Good for learning
- Easy rollback

**Steps:**

1. **Install Heroku CLI**
   ```bash
   curl https://cli-assets.heroku.com/install.sh | sh
   ```

2. **Login to Heroku**
   ```bash
   heroku login
   ```

3. **Create Heroku App**
   ```bash
   cd /workspaces/Better-royal
   heroku create better-royal-app  # Replace with your app name
   ```

4. **Deploy Code**
   ```bash
   git push heroku main
   ```

5. **View Logs**
   ```bash
   heroku logs --tail
   ```

**Live URL Format:** `https://better-royal-app-xxxx.herokuapp.com`

---

### **Option 3: Docker Deployment (AWS/Google Cloud/DigitalOcean)**

**Advantages:**
- Full control
- Scalable
- Works everywhere
- Good for production

**Steps:**

1. **Build Docker Image**
   ```bash
   cd /workspaces/Better-royal
   docker build -t better-royal-tts .
   ```

2. **Push to Docker Hub** (if using Docker Hub registry)
   ```bash
   docker tag better-royal-tts yourusername/better-royal-tts
   docker push yourusername/better-royal-tts
   ```

3. **Deploy on Your Server**
   ```bash
   # On your server
   docker pull yourusername/better-royal-tts
   docker run -d -p 80:5000 yourusername/better-royal-tts
   ```

---

### **Option 4: Run on Your Own Server**

**For Ubuntu/Debian Server:**

```bash
# 1. SSH into server
ssh user@your-server.com

# 2. Install Python and dependencies
sudo apt update
sudo apt install python3 python3-pip python3-venv
sudo apt install espeak espeak-ng libsndfile1

# 3. Clone repository
git clone https://github.com/onlykingshoaib/Better-royal.git
cd Better-royal

# 4. Setup virtual environment
python3 -m venv venv
source venv/bin/activate

# 5. Install dependencies
pip install -r tts-app/requirements.txt

# 6. Run with Gunicorn
cd tts-app
gunicorn -w 4 -b 0.0.0.0:8000 app:app

# 7. Use Nginx as reverse proxy (optional but recommended)
# Configure Nginx to forward requests to localhost:8000
```

---

## 📋 Files Created for Deployment

### **vercel.json**
```json
{
  "version": 2,
  "builds": [
    {
      "src": "tts-app/app.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "tts-app/app.py"
    }
  ],
  "env": {
    "FLASK_ENV": "production"
  }
}
```
→ Used for Vercel deployment

### **Procfile**
```
web: gunicorn -w 4 -b 0.0.0.0:$PORT tts-app.app:app
```
→ Used for Heroku deployment

### **runtime.txt**
```
python-3.9.16
```
→ Specifies Python version for Heroku

### **requirements.txt (Updated)**
- Added `gunicorn==21.2.0` (production server)
- Added `python-dotenv==1.0.0` (environment variables)
- Added `Jinja2==3.1.2` (Flask template engine)

### **.env.example**
```
FLASK_ENV=development
FLASK_DEBUG=True
FLASK_HOST=0.0.0.0
FLASK_PORT=5000
```
→ Template for development setup

---

## 🔒 Production Security Checklist

### Before Deploying:

- ✅ **Secret Key:** Set a unique `SECRET_KEY` in environment
- ✅ **Debug Mode:** Set `FLASK_DEBUG=False` in production
- ✅ **HTTPS:** Enable SSL/TLS (auto on Vercel/Heroku)
- ✅ **CORS:** Configure for your domain
- ✅ **Logging:** Enable for monitoring
- ✅ **Database:** Use managed database if adding persistence

### Set Environment Variables in Deployment:

**Vercel:**
1. Go to Project Settings
2. Click "Environment Variables"
3. Add:
   ```
   FLASK_ENV=production
   FLASK_DEBUG=False
   SECRET_KEY=your-random-secret-key-here
   ```

**Heroku:**
```bash
heroku config:set FLASK_ENV=production
heroku config:set FLASK_DEBUG=False
heroku config:set SECRET_KEY=your-random-secret-key-here
```

---

## 🧪 Testing Before Deployment

### Local Production Test

```bash
cd /workspaces/Better-royal/tts-app

# 1. Install production dependencies
pip install gunicorn

# 2. Run with Gunicorn (simulates production)
FLASK_ENV=production gunicorn -w 4 -b 0.0.0.0:5000 app:app

# 3. Test in browser
# Open: http://localhost:5000

# 4. Check it works:
# - Text input works
# - Voices load
# - Play button works
# - All sliders respond
```

---

## 📊 Deployment Comparison

| Platform | Cost | Setup Time | Scalability | Recommendation |
|----------|------|-----------|-------------|-----------------|
| **Vercel** | Free/Paid | 5 mins | Excellent | ⭐⭐⭐ Best for beginners |
| **Heroku** | Free/Paid | 10 mins | Good | ⭐⭐ Good alternative |
| **Docker** | Varies | 20 mins | Excellent | ⭐⭐⭐ For control |
| **AWS/GCP** | Varies | 30+ mins | Excellent | ⭐⭐⭐ For scale |

---

## ✨ Quick Deploy Commands

### **Deploy to Vercel (One Click)**
1. Go to: https://vercel.com/new
2. Import: https://github.com/onlykingshoaib/Better-royal
3. Deploy!

### **Deploy to Heroku (5 Commands)**
```bash
heroku login
heroku create better-royal-app
git push heroku main
heroku open
heroku logs --tail
```

### **Deploy with Docker**
```bash
docker build -t better-royal .
docker run -p 8000:5000 better-royal
```

---

## 🎯 Post-Deployment

### Monitor Your App

**Vercel:**
- Dashboard: https://vercel.com/dashboard
- View logs, analytics, deployments

**Heroku:**
```bash
heroku logs --tail
heroku status
heroku ps
```

### Access Your App

**Vercel:** `https://your-app-name.vercel.app`  
**Heroku:** `https://your-app-name.herokuapp.com`  
**Docker:** `http://your-server-ip:8000`

### Enable HTTPS

- **Vercel:** Automatic (free SSL)
- **Heroku:** Automatic (free SSL)
- **Docker:** Use Nginx/Caddy with Let's Encrypt

---

## 🔧 Troubleshooting Deployment

### Issue: "No module named 'pyttsx3'"
**Solution:**
- Vercel: pyttsx3 requires system audio library
- Recommendation: Use GitHub Actions to build or use pure Python alternatives

### Issue: "Port already in use"
**Solution:**
```bash
python -c "import socket; s = socket.socket(); s.bind(('', 0)); print(s.getsockname()[1])"
# Use the returned port number
```

### Issue: "502 Bad Gateway"
**Solution:**
- Check logs: `heroku logs --tail`
- Verify requirements.txt installed
- Check environment variables set
- Restart: `heroku restart` or redeploy

### Issue: "Build failed"
**Solution:**
- Check buildlog for errors
- Verify requirements.txt syntax
- Ensure Procfile is correct
- Try rebuilding locally first

---

## 📱 Testing Deployment

After deploying, test these features:

**Should Work:**
- ✅ Text input
- ✅ Voice selection
- ✅ Play button
- ✅ Volume/Speed/Pitch sliders
- ✅ Stop button
- ✅ Status updates
- ✅ Test voice

**Might Not Work:**
- ❌ Actual audio playback (depends on platform's audio support)
- Note: Some serverless platforms don't support audio synthesis

---

## 🎓 Production Best Practices

1. **Environment Variables:** Store secrets in environment, not code
2. **Logging:** Monitor for errors and performance
3. **Backups:** Regular backups if using database
4. **Monitoring:** Set up alerts for downtime
5. **Updates:** Keep dependencies updated
6. **Testing:** Test before deploying
7. **Rollback:** Keep previous versions available
8. **Documentation:** Document your setup

---

## 🔗 Useful Links

- **Vercel Docs:** https://vercel.com/docs
- **Heroku Docs:** https://devcenter.heroku.com/
- **Flask Deployment:** https://flask.palletsprojects.com/deployment/
- **Gunicorn Docs:** https://gunicorn.org/
- **Docker Docs:** https://docs.docker.com/

---

## ✅ Deployment Checklist

Before going live:

- [ ] GitHub repository updated and pushed
- [ ] requirements.txt has all dependencies
- [ ] .env.example created and documented
- [ ] Vercel/Heroku/Docker configuration files created
- [ ] Local production test successful
- [ ] No console errors in browser
- [ ] All features tested
- [ ] Environment variables configured on platform
- [ ] HTTPS enabled
- [ ] Monitoring setup

---

## 🎉 Next Steps

### To Deploy to Vercel (Recommended):
1. Go to https://vercel.com/new
2. Click "Continue with GitHub"
3. Select "Better-royal" repository
4. Click "Deploy"
5. Wait 1-2 minutes
6. You have a live app! 🎉

### To Deploy to Heroku:
```bash
heroku create your-app-name
git push heroku main
heroku open
```

### To Deploy with Docker:
```bash
docker build -t better-royal .
docker run -p 8000:5000 better-royal
# Visit http://localhost:8000
```

---

## 📞 Support

For deployment issues:
1. Check platform logs (Vercel/Heroku)
2. Review troubleshooting section above
3. Check Flask documentation
4. Review GitHub Actions workflows

---

**Deployment Status:** ✅ Ready for Production  
**Last Updated:** May 9, 2026  
**License:** MIT

🚀 **Your app is ready to go live!**
