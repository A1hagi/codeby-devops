#!/bin/bash

# Создаем папку, если её нет. -p предотвращает ошибку, если папка существует
mkdir -p "$HOME/myfolder"

# Файл 1: Перезаписываем приветствием и текущей датой
echo "Привет!" > "$HOME/myfolder/1"
date >> "$HOME/myfolder/1"

# Файл 2: Создаем, если нет, и принудительно выставляем права 777
touch "$HOME/myfolder/2"
chmod 777 "$HOME/myfolder/2"

# Файл 3: Генерируем 20 случайных символов (буквы и цифры)
LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 20 > "$HOME/myfolder/3"
echo "" >> "$HOME/myfolder/3" # Добавляем перенос строки для корректности

# Файлы 4 и 5: Создаем пустые файлы
touch "$HOME/myfolder/4" "$HOME/myfolder/5"
