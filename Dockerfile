FROM golang:1.24.0 AS build

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o app .

# Run stage
FROM debian:bullseye-slim

WORKDIR /app
COPY --from=build /app/app .

CMD ["./app"]
