FROM php:latest

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx

RUN docker-php-ext-install \
    pdo_mysql \
    gd \
    mbstring \
    zip \
    soap \
    curl \
    bcmath 


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN a2enmod rewrite

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
