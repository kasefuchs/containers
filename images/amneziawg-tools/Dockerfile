FROM alpine:3.24.1 AS build

RUN apk add --no-cache build-base git linux-headers

ARG AMNEZIAWG_TOOLS_VERSION

WORKDIR /usr/src

RUN git clone --branch v${AMNEZIAWG_TOOLS_VERSION} --depth 1 https://github.com/amnezia-vpn/amneziawg-tools.git

WORKDIR /usr/src/amneziawg-tools/src

RUN make install BINDIR=/usr/local/bin WITH_WGQUICK=yes LDFLAGS="-static -no-pie"

FROM scratch

COPY --from=build /usr/local/bin/ /usr/local/bin/
