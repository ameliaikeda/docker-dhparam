FROM alpine:latest

RUN apk --update add openssl \
    && openssl dhparam -out /etc/ssl/dhparam.pem 4096 \
    && openssl req -newkey rsa:2048 -x509 \
        -keyout /etc/ssl/snakeoil-key.pem \
        -out /etc/ssl/snakeoil-cert.pem \
        -days 365 -nodes -subj "/CN=example.com" \
    && apk del openssl \
    && rm -rf /var/cache/apk/*
