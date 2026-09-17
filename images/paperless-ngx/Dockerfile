ARG PAPERLESS_NGX_VERSION

FROM ghcr.io/paperless-ngx/paperless-ngx:${PAPERLESS_NGX_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --assume-yes && \
    apt-get install --assume-yes --no-install-recommends tesseract-ocr-rus && \
    apt-get clean --assume-yes
