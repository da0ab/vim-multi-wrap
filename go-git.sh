#!/bin/bash

# Проверяем, передан ли токен
if [ -z "$1" ]; then
  echo "Использование: ./go-git.sh <TOKEN>"
  exit 1
fi

TOKEN=$1
USERNAME="da0ab"  # Замените на ваш GitHub username
REPO_URL="github.com/da0ab/vim-multi-wrap"  # Замените на URL вашего репозитория

# Обновляем локальную ветку с удалённой
git pull https://$USERNAME:$TOKEN@$REPO_URL master

# Добавляем все изменения
git add .

# Создаём коммит с сообщением
git commit -m "Обновление проекта"

# Отправляем изменения на удалённый репозиторий
git push https://$USERNAME:$TOKEN@$REPO_URL master



