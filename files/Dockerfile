FROM alpine

RUN apk add --no-cache php7-cli php7-session php7-mysqli php7-pecl-memcached

COPY . /app

WORKDIR /app

CMD php -c /app/files/php.ini -S 0.0.0.0:8080
