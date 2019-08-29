FROM golang:1.12-alpine AS builder
WORKDIR /go/src/github.com/raj47i/http-server/
COPY ./main.go .
RUN go build -v -o app

FROM alpine:latest
LABEL maintainer="Raj <web@arunraj.in>"

RUN adduser -D -G users docker && \
    apk update && \
    apk add --no-cache openssl ca-certificates wget && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /go/src/github.com/raj47i/http-server/app /home/docker/app

RUN mkdir /home/docker/www && \
    chown docker:users -Rf /home/docker && \
    chmod +x /home/docker/app

WORKDIR /home/docker
VOLUME /www
EXPOSE 8080

USER docker
ENTRYPOINT ["/home/docker/app"]
