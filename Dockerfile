FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache nginx supervisor

# Install PHP extensions for WordPress
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Configure Nginx
COPY ./nginx.conf /etc/nginx/http.d/default.conf

# Set working directory and copy code
WORKDIR /var/www/html
COPY . .

# Fix permissions for the web user
RUN chown -R www-data:www-data /var/www/html

# Use Supervisor to run both Nginx and PHP-FPM
COPY ./supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]