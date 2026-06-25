#!/bin/bash

TARGET_DIR="$HOME/myfolder"

# Проверяем существование папки, чтобы избежать ошибок при запуске скрипта
if [ ! -d "$TARGET_DIR" ]; then
    echo "Папка $TARGET_DIR не существует. Нечего обрабатывать."
    exit 0
fi

# 1. Определяем, сколько файлов в папке (считаем только файлы, исключая подпапки)
file_count=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)
echo "Количество файлов в папке: $file_count"

# 2. Исправляем права второго файла, если он существует
if [ -f "$TARGET_DIR/2" ]; then
    chmod 664 "$TARGET_DIR/2"
fi

# 3. Находим пустые файлы и удаляем их (-size 0)
find "$TARGET_DIR" -maxdepth 1 -type f -size 0 -delete

# 4. Удаляем все строки кроме первой в оставшихся файлах
for file in "$TARGET_DIR"/*; do
    # Проверяем, что это обычный файл и он существует (на случай пустой папки)
    if [ -f "$file" ]; then
        # Читаем только первую строку и перезаписываем файл
        first_line=$(head -n 1 "$file")
        echo "$first_line" > "$file"
    fi
done
