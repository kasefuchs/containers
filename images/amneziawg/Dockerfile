FROM alpine:3.24.2

RUN apk add --no-cache bash

COPY --from=amneziawg-go /usr/local/bin/ /usr/local/bin/
COPY --from=amneziawg-tools /usr/local/bin/ /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/amneziawg-go"]
