FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies for TTS
RUN apt-get update && apt-get install -y \
    espeak \
    espeak-ng \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .
COPY config.py .
COPY templates/ templates/
COPY static/ static/

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000')" || exit 1

# Run the application
CMD ["python", "app.py"]
