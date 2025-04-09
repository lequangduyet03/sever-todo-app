FROM golang:1.21-buster AS build

WORKDIR /app
COPY . .

RUN go mod download
RUN go build -o app .

FROM debian:buster

WORKDIR /app
COPY --from=build /app/app .

CMD ["./app"]
