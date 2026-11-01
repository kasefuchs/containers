FROM alpine:3.24.3

RUN apk add --no-cache gettext-envsubst

COPY rootfs/ /

WORKDIR /workdir

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
