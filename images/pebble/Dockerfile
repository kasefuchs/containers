FROM --platform=$BUILDPLATFORM golang:1.26.5 AS build

ARG TARGETOS
ARG TARGETARCH
ARG PEBBLE_VERSION

ENV GOOS=${TARGETOS}
ENV GOARCH=${TARGETARCH}
ENV CGO_ENABLED=0

WORKDIR $GOPATH/src/github.com/canonical

RUN git clone --branch v${PEBBLE_VERSION} --depth 1 https://github.com/canonical/pebble.git

WORKDIR $GOPATH/src/github.com/canonical/pebble

RUN go build -o $GOPATH/bin/pebble ./cmd/pebble/

FROM alpine:3.24.1

COPY --from=build /go/bin/pebble /usr/local/bin/pebble

ENTRYPOINT ["/usr/local/bin/pebble"]
CMD ["run"]
