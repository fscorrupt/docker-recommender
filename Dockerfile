# Use a lightweight Python base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    python3-pyqt6 \
    x11vnc \
    xvfb \
    fluxbox \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/novnc/utils/websockify && \
    wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz | tar xz -C /opt/novnc --strip-components=1 && \
    wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.10.0.tar.gz | tar xz -C /opt/novnc/utils/websockify --strip-components=1

# Copy application code into the container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Environment variables to prevent Python from writing bytecode and buffering output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Expose necessary ports for VNC and noVNC
EXPOSE 5900 6080

# Command to launch the application with GUI
CMD ["bash", "-c", "\
    Xvfb :99 -screen 0 1024x768x16 & \
    export DISPLAY=:99 && \
    fluxbox & \
    x11vnc -forever -shared -rfbport 5900 -display WAIT:99 & \
    /opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080 & \
    python main.py"]
