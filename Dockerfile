# Use Debian-base
FROM jlesage/baseimage-gui:alpine-3.18-v4.7.0

# Set working directory
WORKDIR /app

# Install system dependencies and cleanup after install
RUN apk update && apk add --no-cache \
    sqlite \
    bash \
    && rm -rf /var/cache/apk/*

# Create and activate virtual environment
RUN python3 -m venv /venv

# Copy application files
COPY . /app

# Install Python dependencies into virtual environment
RUN /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /app/requirements.txt

# Copy start script
COPY startapp.sh /startapp.sh

# Make the start script executable
RUN chmod +x /startapp.sh

# Set environment variable for the application name
ENV APP_NAME="Recommender"

# Expose the default VNC port
EXPOSE 5800

# Command to run the application
CMD ["/startapp.sh"]