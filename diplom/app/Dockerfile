# --- Этап 1: Сборка и статическая компиляция бинарного файла ---
FROM golang:1.22-alpine AS builder

WORKDIR /build

# Копируем исходный код приложения
COPY main.go .

# Инициализируем go-модуль и компилируем бинарник без отладочных символов для уменьшения веса
RUN go mod init diploma-app && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o webapp main.go

# --- Этап 2: Финальный минимальный рантайм-образ без компиляторов ---
FROM alpine:3.19

WORKDIR /app

# Переносим скомпилированный бинарный артефакт из первого этапа
COPY --from=builder /build/webapp .

# Открываем порт веб-сервера внутри сети Kubernetes
EXPOSE 8080

# Запуск готового откомпилированного Go-приложения
CMD ["./webapp"]
