# --- Этап 1: Сборка приложения (Builder) ---
FROM golang:1.20-alpine AS builder

WORKDIR /build

# Копируем наш файл main.go внутри контекста
COPY app/main.go .

# Инициализируем модуль проекта и компилируем его в один бинарник 'server'
RUN go mod init myapp && CGO_ENABLED=0 GOOS=linux go build -o server main.go

# --- Этап 2: Финальный образ для запуска ---
FROM alpine:latest

WORKDIR /app

# Копируем скомпилированный файл из первого этапа
COPY --from=builder /build/server .

# Открываем порт 8080
EXPOSE 8080

# Команда для запуска веб-сервера
CMD ["./server"]
