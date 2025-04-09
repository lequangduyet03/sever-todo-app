# Stage 1: Build
FROM golang:1.24 AS build
WORKDIR /app

# Copy go.mod và tải thư viện
COPY go.mod go.sum ./
RUN go mod download

# Copy toàn bộ source code
COPY . .

# Build ứng dụng
RUN go build -o app

# Stage 2: Run
FROM debian:bullseye-slim
WORKDIR /app

# Copy binary từ stage build
COPY --from=build /app/app .

# Mở port
EXPOSE 8080

# Run app
ENTRYPOINT ["./app"]
