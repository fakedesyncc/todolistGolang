FROM golang:1.20-alpine AS builder

WORKDIR /app
COPY go.mod .
COPY cmd ./cmd

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /todo-api ./cmd/server/main.go

FROM alpine:latest
COPY --from=builder /todo-api /todo-api

EXPOSE 8080
CMD ["/todo-api"]
