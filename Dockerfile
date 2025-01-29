# Use Debian based GUI image
FROM jlesage/baseimage-gui:debian-11-v4.7.0

# Set working directory
WORKDIR /app

# Install Python and system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    sqlite3 \
    && apt-get clean

# Create and activate virtual environment
RUN python3 -m venv /venv

# Copy application files
COPY . /app

# Activate virtual environment and install dependencies
RUN . /venv/bin/activate && pip install --upgrade pip && pip install -r /app/requirements.txt

# Copy start script
COPY startapp.sh /startapp.sh

# Make the start script executable
RUN chmod +x /startapp.sh

# Set the name of the application
RUN set-cont-env APP_NAME "Recommender"

# Expose the default VNC port
EXPOSE 5800

# Command to run the application
CMD ["/startapp.sh"]
