FROM php:8-apache-buster

ARG DEBIAN_FRONTEND=noninteractive

RUN chmod 777 /tmp && chmod +t /tmp

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    locales \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    vim \
    git \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

RUN sed -i -e 's/# fr_CH.UTF-8 UTF-8/fr_CH.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=fr_CH.UTF-8

ENV LANG fr_CH.UTF-8
ENV LANGUAGE fr_CH.UTF-8
ENV LC_ALL fr_CH.UTF-8

RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
        mysqli \
        curl \
        zip \
        ldap \
        gd \
        intl \
        xmlrpc \
        soap \
        opcache \
        pdo_mysql \
        ctype \
        dom \
        iconv \
        json \
        zlib \
        mbstring \
        pcre \
        simplexml \
        spl \
        xml \
        exif

RUN mkdir /var/www/data \
    && chown -R www-data:www-data /var/www/data \
    && chmod -R 770 /var/www/data

RUN git clone --depth 1 --branch v4.3.2 https://github.com/moodle/moodle.git /var/www/html/moodle

COPY ./additional.ini /usr/local/etc/php/conf.d/additional.ini
COPY ./vhost.template /etc/apache2/sites-enabled/project.conf
COPY ./config.php /var/www/html/moodle

RUN chown -R root:root /var/www/html/moodle \
    && find /var/www/html/moodle -type d -exec chmod 555 {} \; \
    && find /var/www/html/moodle -type f -exec chmod 444 {} \;

USER www-data