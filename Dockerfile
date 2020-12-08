FROM golang:1.15.6-alpine3.12 as builder

RUN apk update && apk add --no-cache --virtual .build-deps wget git
COPY app.go /go

RUN go get github.com/gorilla/mux

RUN cd /go && \
    go build app.go

FROM alpine:3.12
COPY --from=builder /go/app /usr/bin/hello-world
ENTRYPOINT ["hello-world"]
