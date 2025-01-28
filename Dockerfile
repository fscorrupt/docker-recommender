# Use the jlesage/baseimage-gui image as the base
FROM jlesage/baseimage-gui:latest

# Set working directory
WORKDIR /app

# Copy application files into the container
COPY . /app

# Install required system dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    sqlite \
    && pip3 install --upgrade pip

# Install Python dependencies
RUN pip3 install -r /app/requirements.txt

# Expose the default VNC port
EXPOSE 5800

# Set environment variables for GUI
ENV APP_NAME="Recommender"

# Command to run your Python application
CMD ["python3", "/app/main.py"]
