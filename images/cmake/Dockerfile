FROM debian:13.6-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb http://deb.debian.org/debian trixie-backports main" > /etc/apt/sources.list.d/backports.list

RUN apt-get update --assume-yes && \
    apt-get install --assume-yes --no-install-recommends ca-certificates clang curl doxygen dpkg-dev file git graphviz pkg-config ninja-build tar unzip zip -t trixie-backports cmake && \
    apt-get clean --assume-yes
