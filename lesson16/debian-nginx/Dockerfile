FROM debian:11-slim

# Обновляем пакеты, ставим nginx и очищаем кэш для уменьшения размера образа
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Создаем папку для статики
RUN mkdir -p /opt/www

# Копируем конфигурацию и HTML
COPY index.html /opt/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf

# Открываем порт 80
EXPOSE 80

# Запуск nginx в foreground режиме через ENTRYPOINT
ENTRYPOINT ["nginx", "-g", "daemon off;"]
