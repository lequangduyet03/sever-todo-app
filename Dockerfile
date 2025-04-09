FROM golang:1.24 AS build

WORKDIR /app
COPY . .

# Build binary tĩnh
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

# Runtime image nhỏ, không cần libc
FROM scratch

WORKDIR /app
COPY --from=build /app/app .

ENTRYPOINT ["/app/app"]
