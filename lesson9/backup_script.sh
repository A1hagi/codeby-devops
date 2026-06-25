#!/bin/bash
BACKUP_DIR="/opt/mysql_backup"
STORE_IP="192.168.56.11"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="mysql_backup_$TIMESTAMP.sql.gz"

mysqldump --opt --all-databases | gzip > "$BACKUP_DIR/$BACKUP_NAME"
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -delete
rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" "$BACKUP_DIR/" root@"$STORE_IP":/opt/store/mysql/
