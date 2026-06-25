#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

NAME="Alhagi"

DOMAIN="${NAME}.local"
WWW_DOMAIN="www.${NAME}.local"
SERVER_IP="192.168.56.10"

# Запись в /etc/hosts
echo "${SERVER_IP} ${DOMAIN} ${WWW_DOMAIN}" | sudo tee -a /etc/hosts

# Ждем сертификат от сервера
while [ ! -f /vagrant/apache-selfsigned.crt ]; do
  sleep 2
done

# Добавляем в доверенные
sudo cp /vagrant/apache-selfsigned.crt /usr/local/share/ca-certificates/apache-selfsigned.crt
sudo update-ca-certificates

sudo apt-get update && sudo apt-get install -y curl
