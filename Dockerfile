FROM s390x/php:7.4-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        curl libcurl4-openssl-dev \
        libonig-dev \
        nginx \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd curl session fileinfo json mbstring mysqli \
    && rm /etc/nginx/sites-available/default \
    && rm /var/www/html/index.nginx-debian.html

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY --chown=www-data src/ /var/www/html/

COPY config/entrypoint.sh /etc/entrypoint.sh

EXPOSE 80

CMD sh /etc/entrypoint.sh
