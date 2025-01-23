# Use jlesage/docker-baseimage-gui as the base image
FROM jlesage/docker-baseimage-gui:debian-11

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Set environment variables required by the base image
ENV APP_NAME="RECOMMENDER WEB GUI"
ENV KEEP_APP_RUNNING=1


# Install dependencies and application requirements
RUN apt-get update && apt-get install -y \
    sqlite3 \
    python3-pyqt6 \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -r requirements.txt

# Expose the VNC port used by the base image (default: 5800)
EXPOSE 5800

# Define the command to run the GUI application
CMD ["python3", "/app/main.py"]
