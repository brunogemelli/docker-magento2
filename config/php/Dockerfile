FROM php:7.2.11-fpm

RUN apt-get update && apt-get install -y --allow-unauthenticated \
		libmcrypt-dev  \
		libicu-dev \
		mysql-client \
		libfreetype6-dev \
		libmcrypt-dev \
		libxml2-dev \
		libxslt-dev \
		libjpeg62-turbo-dev \ 
		g++ \
        golang-go \
        git-core \
        vim \
    && pecl install mcrypt-1.0.1 \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install pdo \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install xml \
	&& docker-php-ext-install soap \
	&& docker-php-ext-install xsl \
	&& docker-php-ext-install zip \
	&& docker-php-ext-install json \
	&& docker-php-ext-install bcmath \
	&& pecl install xdebug \
	&& docker-php-ext-enable xdebug \
	&& docker-php-ext-enable mcrypt;

#&& docker-php-ext-install mcrypt \

### Install Mailhog
ENV GOPATH /tmp
RUN cd /tmp
RUN go get github.com/mailhog/mhsendmail
RUN cd /tmp/src/github.com/mailhog/mhsendmail/ && go build
RUN cp /tmp/src/github.com/mailhog/mhsendmail/mhsendmail /usr/local/bin

# Configure
COPY php.ini /usr/local/etc/php/php.ini
COPY php-fpm.conf /usr/local/etc/
COPY ext-xdebug.ini /usr/local/etc/php/conf.d/ext-xdebug.ini

#COMPOSER
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && rm composer-setup.php \
    && mv composer.phar /usr/bin/composer;

# Make sure the volume mount point is empty
RUN rm -rf /var/www/html/*

CMD ["php-fpm"]