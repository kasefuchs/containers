FROM alpine:3.24.1

RUN apk add --no-cache gettext-envsubst

COPY rootfs/ /

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
