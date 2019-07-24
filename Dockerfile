FROM isaackuang/alpine-base:3.8.0

RUN apk add --update curl ca-certificates && \
    curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories && \
    apk --no-cache --progress add \
    php7@php php7-cli@php php7-curl@php php7-openssl@php php7-json@php php7-iconv@php \
    php7-phar@php php7-mbstring@php php7-session@php php7-tokenizer@php && \
    rm /var/cache/apk/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
    
RUN /usr/bin/composer global require phpmv/ubiquity-devtools && \
    ln -s /root/.composer/vendor/bin/Ubiquity /usr/bin/Ubiquity

WORKDIR /var/www/html

ENTRYPOINT ["/init"]

COPY config /
