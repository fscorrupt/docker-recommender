# Use the jlesage/baseimage-gui image as the base
FROM jlesage/baseimage-gui:debian-11-v4

# Set working directory
WORKDIR /app

# Copy application files into the container
COPY . /app

# Install Python and dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sqlite3 \
    && apt-get clean

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Expose the default VNC port
EXPOSE 5800


# Set environment variables for GUI
ENV APP_NAME="Recommender"

# Command to run your Python application
CMD ["python3", "/app/main.py"]
