# Use jlesage/docker-baseimage-gui as the base image
FROM jlesage/baseimage-gui:debian-12-v4

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Set environment variables required by the base image
ENV APP_NAME="RECOMMENDER WEB GUI"
ENV KEEP_APP_RUNNING=1

# Install system dependencies, Python pip, and virtual environment module
RUN apt-get update && apt-get install -y \
    sqlite3 \
    python3-pyqt6 \
    python3-pip \
    python3-venv \
    libgl1 \
    PySide6 \
    && rm -rf /var/lib/apt/lists/*

# Create and activate a Python virtual environment, then install requirements
RUN python3 -m venv /app/venv \
    && /app/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Expose the VNC port used by the base image (default: 5800)
EXPOSE 5800

# Use the virtual environment Python to run the application
CMD ["/app/venv/bin/python", "/app/main.py"]
