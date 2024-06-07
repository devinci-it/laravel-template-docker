# -----------------------------------------------------------------------------
# Base Image and Environment Setup
# -----------------------------------------------------------------------------
FROM php:8.3

# -----------------------------------------------------------------------------
# Environment Setup
# -----------------------------------------------------------------------------
# This Dockerfile is intended for local development environment setup only.
# These settings should not be used for production deployments.
ARG PROJECT_NAME=laravel-template

# Set application name based on the project name
ENV APP_NAME=${PROJECT_NAME}

# Set MySQL user, password, and database name based on the project name
ENV MYSQL_USER=${PROJECT_NAME}user
ENV MYSQL_PASSWORD=${PROJECT_NAME}password
ENV MYSQL_DATABASE=${PROJECT_NAME}

# -----------------------------------------------------------------------------
# Dependency Installation
# -----------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -y \
        curl \
        git \
        unzip \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libxml2-dev \
        zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql mbstring exif pcntl bcmath opcache \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Composer Setup
# -----------------------------------------------------------------------------
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

# Add Composer binaries to PATH
ENV PATH="${PATH}:/root/.composer/vendor/bin"

# -----------------------------------------------------------------------------
# Laravel Initialization
# -----------------------------------------------------------------------------
WORKDIR /var/www

# Create Laravel project
RUN composer create-project --prefer-dist laravel/laravel ${PROJECT_NAME} \
    && chown -R www-data:www-data /var/www/${PROJECT_NAME}

# Set working directory for Laravel project
WORKDIR /var/www/${PROJECT_NAME}

# -----------------------------------------------------------------------------
# Installing Application Dependencies
# -----------------------------------------------------------------------------
RUN composer install --ignore-platform-reqs

# -----------------------------------------------------------------------------
# Exposing Ports
# -----------------------------------------------------------------------------
EXPOSE 8000

# -----------------------------------------------------------------------------
# Running Services
# -----------------------------------------------------------------------------
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
