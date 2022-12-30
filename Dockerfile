FROM wordpress:6.1.1-php8.1-apache

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --no-install-recommends -y zlib1g-dev libzip-dev zlib1g libmemcached-dev \
&& rm -rf /var/lib/apt/lists/* \
&& docker-php-ext-configure zip \
&& docker-php-ext-install zip

RUN pecl install -o -f redis \
&& pecl install memcached \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis \
&& docker-php-ext-enable memcached \
&& echo "extension=redis.so" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "extension=memcached.so" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "memory_limit = 256M" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "upload_max_filesize = 256M" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "post_max_size = 8M" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "max_execution_time = 600" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "max_input_time = 600" >> $PHP_INI_DIR/conf.d/custom.ini \
&& echo "extension=redis.so" >> $PHP_INI_DIR/conf.d/custom.ini