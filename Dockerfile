# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.19-v4

# Set working directory.
WORKDIR /app

# Install Python, pip, and system dependencies.
RUN add-pkg python3 py3-pip sqlite && \
    python3 -m venv /venv && \
    . /venv/bin/activate && \
    pip install --upgrade pip

# Copy application files into the /app directory.
COPY . /app

# Activate virtual environment and install dependencies.
RUN . /venv/bin/activate && \
    pip install -r /app/requirements.txt

# Copy the start script to the container root.
COPY startapp.sh /startapp.sh

# Make the start script executable.
RUN chmod +x /startapp.sh

# Set the name of the application.
RUN set-cont-env APP_NAME "Recommender"

# Expose the default VNC port.
EXPOSE 5800

# Command to run the application.
CMD ["/startapp.sh"]
