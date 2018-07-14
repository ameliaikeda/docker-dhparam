# amelia/dhparam

Need a dhparam.pem that can cycle? Don't want to wait a year for the build to complete?

Don't use this image directly as a base; use it as a multi-stage build object, like so:

```
FROM amelia/dhparam:latest as dhparam
FROM alpine:latest

COPY --from=dhparam /dhparam.pem /etc/nginx/dhparam.pem
COPY --from=dhparam /snakeoil-cert.pem /etc/nginx/certs/certificate.pem
COPY --from=dhparam /snakeoil-key.pem /etc/nginx/certs/privkey.pem
```

This image will be updated + cycled periodically; it's not a requirement for diffie-hellman params to be unique, but they shouldn't be standard hardcoded values. Daily updating is a sufficient tradeoff here.
