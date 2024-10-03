# Use the official PHP Apache image as the base
FROM php:8.0-apache

# Copy the application files into the container
COPY src/ /var/www/html/

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

