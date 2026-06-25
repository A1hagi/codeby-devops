#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# !!! ИМЯ ДЛЯ ДОМЕНА !!!
NAME="Alhagi"

DOMAIN="${NAME}.local"
WWW_DOMAIN="www.${NAME}.local"
WEB_ROOT="/var/www/${DOMAIN}/html"

# Установка Apache
sudo apt-get update
sudo apt-get install -y apache2 ssl-cert

# Создание директорий
sudo mkdir -p "${WEB_ROOT}"
sudo chown -R vagrant:vagrant "/var/www/${DOMAIN}"
sudo chmod -R 755 "/var/www/${DOMAIN}"

# Демо-страница
cat <<EOD > "${WEB_ROOT}/index.html"
<html>
<head><title>Welcome to ${DOMAIN}!</title></head>
<body><h1>You are running ${DOMAIN} securely on HTTPS!</h1></body>
</html>
EOD

# Генерируем self-signed сертификат OpenSSL
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /vagrant/apache-selfsigned.crt \
  -subj "/C=RU/ST=State/L=City/O=Organization/OU=IT/CN=${DOMAIN}"

sudo cp /vagrant/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt

# Конфиг VirtualHost (Редирект HTTP -> HTTPS и WWW -> non-WWW)
sudo cat <<EOD > "/etc/apache2/sites-available/${DOMAIN}.conf"
<VirtualHost *:80>
    ServerName ${DOMAIN}
    ServerAlias ${WWW_DOMAIN}
    ServerAdmin admin@${DOMAIN}
    Redirect permanent / https://${DOMAIN}/
</VirtualHost>

<VirtualHost *:443>
    ServerName ${DOMAIN}
    ServerAlias ${WWW_DOMAIN}
    ServerAdmin admin@${DOMAIN}
    DocumentRoot ${WEB_ROOT}

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
    RewriteRule ^(.*)$ https://%1\$1 [R=301,L]

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOD

echo "ServerName ${DOMAIN}" | sudo tee /etc/apache2/conf-available/${DOMAIN}.conf

# Активация модулей и перезапуск
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite "${DOMAIN}.conf"
sudo a2enconf "${DOMAIN}"
sudo a2dissite 000-default.conf

sudo apache2ctl configtest
sudo systemctl enable apache2
sudo systemctl restart apache2
