# Use jlesage/docker-baseimage-gui as the base image
FROM jlesage/baseimage-gui:debian-12-v4

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Set environment variables required by the base image
ENV APP_NAME="RECOMMENDER WEB GUI"
ENV KEEP_APP_RUNNING=1

# Install system dependencies, OpenGL libraries, Python pip, and virtual environment module
RUN apt-get update && apt-get install -y \
    sqlite3 \
    python3-pyqt6 \
    python3-pip \
    python3-venv \
    libgl1 \
    libegl1 \
    libx11-xcb1 \
    libxcb-glx0 \
    libxcb-icccm4 \
    && rm -rf /var/lib/apt/lists/*

# Create a Python virtual environment in the app directory
RUN python3 -m venv /app/venv \
    && /app/venv/bin/python -m pip install --no-cache-dir --upgrade pip \
    && /app/venv/bin/python -m pip install --no-cache-dir -r /app/requirements.txt

# Ensure the venv is executable
RUN chmod -R 755 /app/venv

# Expose the VNC port used by the base image (default: 5800)
EXPOSE 5800

# Use the virtual environment Python to run the application
CMD ["/app/venv/bin/python3", "/app/main.py"]
