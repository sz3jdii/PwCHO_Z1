# Dockerfile dla time-app

#Obraz php z web serverem
FROM php:7.3-apache
LABEL pl.pollub.time-app="0.0.1"

#zmienne srodowiskowe
ENV APACHE_DOCUMENT_ROOT /var/www/time-app/public

#potrzebne zaleznosci
RUN apt-get update && apt-get install\
	libzip-dev \
        zlib1g-dev \
	git -y && \
	docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    	&& docker-php-ext-install \
      	mbstring \
	zip
# menadzer zaleznosci php
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

#kopia kontekstu aplikacji
RUN mkdir -p /var/www/time-app/
COPY src/ /var/www/time-app/

#konfiguracja apache2 dla laravela
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
RUN a2enmod rewrite
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN cp /var/www/time-app/.env.example /var/www/time-app/.env
RUN chown -R www-data:www-data /var/www/time-app/

#uruchomienie web servera w tle
CMD /usr/sbin/apache2ctl -D FOREGROUND

WORKDIR /var/www/time-app
#instalacja zaleznosci laravela
RUN composer install
RUN php artisan key:generate
