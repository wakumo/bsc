FROM golang:1.15-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git bash

# Temporarily pull a custom Go bundle
ADD https://golang.org/dl/go1.15.5.src.tar.gz /tmp/go.tar.gz
RUN (cd /tmp && tar -xf go.tar.gz)
RUN (cd /tmp/go/src && ./make.bash)
ENV PATH="/tmp/go/bin:${PATH}"

ADD . /go-ethereum
RUN cd /go-ethereum && make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates curl jq
COPY --from=builder /go-ethereum/build/bin/geth /usr/local/bin/

ADD config.toml .
ADD genesis.json .

ADD start.sh /
RUN chmod +x /start.sh

EXPOSE 8545 8546 8547 30303 30303/udp
CMD ["./start.sh"]
