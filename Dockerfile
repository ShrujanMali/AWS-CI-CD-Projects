FROM python:3.8-slim-buster

# Set workdir
WORKDIR /app

# System dependencies in one RUN with cleanup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        awscli \
        ffmpeg \
        libsm6 \
        libxext6 \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python deps
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Then copy rest of app
COPY . .

# Default command
CMD ["python3", "app.py"]
