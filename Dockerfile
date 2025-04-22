# Use the official PHP image as the base image
FROM php:8-cli

# Define IDs for appuser
ENV PGID=500
ENV PUID=500

# Set the working directory
WORKDIR /usr/src/app

# Install necessary PHP extensions
RUN docker-php-ext-install mysqli

# Copy the application files to the container
COPY . .

# Copy the entrypoint script
COPY entrypoint.sh /usr/src/app/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/src/app/entrypoint.sh

# Create a non-root user
RUN groupadd -g $PGID --system appuser && \
    useradd -r -u $PUID -g appuser --system appuser && \
    chown -R appuser:appuser /usr/src/app

USER appuser:appuser

# Set the entrypoint to the custom script
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]