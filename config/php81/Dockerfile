FROM php:8.1.4-fpm

RUN apt update \
    && apt install -y \
        g++ \
        git-core \
        golang-go \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libpng-dev \
        libpq-dev \
        librabbitmq-dev \
        libxml2-dev \
        libxslt-dev \
        libzip-dev \
        mariadb-client \
        sudo \
        vim \
        zip \
        zlib1g-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        mysqli \
        opcache \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        soap \
        sockets \
        xml \
        xsl \
        zip \
    && pecl install amqp \
        redis \
        xdebug \
    && docker-php-ext-enable amqp \
        redis \
        xdebug;

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

#NODE
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash - && \
  apt-get install -y nodejs

RUN npm install -g requirejs;

RUN usermod -u 1000 www-data | chpasswd && adduser www-data sudo
USER www-data

# Make sure the volume mount point is empty
RUN rm -rf /var/www/html/*

CMD ["php-fpm"]
