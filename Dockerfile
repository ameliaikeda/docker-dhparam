FROM alpine:latest as build

RUN apk --update add openssl \
    && openssl dhparam -out /etc/ssl/dhparam.pem 4096 \
    && openssl req -newkey rsa:2048 -x509 \
        -keyout /etc/ssl/snakeoil-key.pem \
        -out /etc/ssl/snakeoil-cert.pem \
        -days 365 -nodes -subj "/CN=example.com" \
    && rm -rf /var/cache/apk/*

FROM scratch as production

COPY --from=build ["/etc/ssl/dhparam.pem", "/etc/ssl/snakeoil-key.pem", "/etc/ssl/snakeoil-cert.pem", "/"]
