FROM --platform=$BUILDPLATFORM golang:1.26.5 AS build

ARG TARGETOS
ARG TARGETARCH
ARG AMNEZIAWG_GO_VERSION

ENV GOOS=${TARGETOS}
ENV GOARCH=${TARGETARCH}
ENV CGO_ENABLED=0

WORKDIR $GOPATH/src

RUN git clone --branch v${AMNEZIAWG_GO_VERSION} --depth 1 https://github.com/amnezia-vpn/amneziawg-go.git

WORKDIR $GOPATH/src/amneziawg-go

RUN make install BINDIR=/go/bin

FROM alpine:3.24.1

COPY --from=build /go/bin/amneziawg-go /usr/local/bin/amneziawg-go

ENTRYPOINT ["/usr/local/bin/amneziawg-go"]
