FROM php:7.1-apache

RUN sed -i \
      -e '/debian-security/d' \
      -e '/security.debian.org/d' \
      -e '/bullseye-updates/d' \
      -e 's|deb.debian.org/debian|archive.debian.org/debian|g' \
      /etc/apt/sources.list \
    && apt-get update -o Acquire::Check-Valid-Until=false \
    && apt-get install -y --no-install-recommends \
        git unzip libzip-dev libpq-dev \
    && docker-php-ext-install pdo_pgsql zip \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:1.10 /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

RUN sed -ri -e 's!/var/www/html!/var/www/html/web!g' \
    /etc/apache2/sites-available/*.conf

ENV COMPOSER_ALLOW_SUPERUSER=1