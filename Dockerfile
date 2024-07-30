FROM golang:1.16-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /go-book-api

FROM alpine:latest

WORKDIR /root/

COPY --from=build /go-book-api ./

EXPOSE 8080

CMD ["./go-book-api"]