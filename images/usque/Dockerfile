FROM --platform=$BUILDPLATFORM golang:1.26.5 AS build

ARG TARGETOS
ARG TARGETARCH
ARG USQUE_VERSION

ENV GOOS=${TARGETOS}
ENV GOARCH=${TARGETARCH}
ENV CGO_ENABLED=0

WORKDIR $GOPATH/src

RUN git clone --branch v${USQUE_VERSION} --depth 1 https://github.com/Diniboy1123/usque.git

WORKDIR $GOPATH/src/usque

RUN go build -o $GOPATH/bin/usque .

FROM alpine:3.24.1

# Install curl for health checks.
RUN apk --no-cache add curl

COPY --from=build /go/bin/usque /usr/local/bin/usque

ENTRYPOINT ["/usr/local/bin/usque"]
