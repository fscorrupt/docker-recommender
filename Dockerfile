# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.19-v4

# Set working directory
WORKDIR /app

# Install Python and required system dependencies.
RUN add-pkg python3 py3-pip sqlite && \
    pip3 install --upgrade pip

# Copy application files into the /app folder (exclude startapp.sh).
COPY . /app/
RUN rm -f /app/startapp.sh

# Copy the start script to a separate location.
COPY startapp.sh /startapp.sh

# Make the start script executable.
RUN chmod +x /startapp.sh

# Install Python dependencies from requirements.txt.
RUN pip3 install -r /app/requirements.txt

# Set the name of the application.
RUN set-cont-env APP_NAME "Recommender"

# Expose the default VNC port for browser-based access.
EXPOSE 5800

# Set the command to run the start script.
CMD ["/startapp.sh"]
