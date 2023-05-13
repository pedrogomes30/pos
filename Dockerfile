FROM php:8.2-fpm

RUN apt-get update && \
    apt-get install -y \
        curl \
        zip \
        unzip \
        git \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev

RUN docker-php-ext-install pdo_mysql gd mbstring zip soap curl bcmath

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --no-interaction --optimize-autoloader --no-scripts

USER www-data

EXPOSE 80

ENV DB_HOST=${DB_HOST}
ENV DB_PORT=${DB_PORT}
ENV DB_DATABASE=${DB_DATABASE}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}

CMD ["apache2-foreground"]
