#!/bin/bash

# Configuration
DB_NAME="your_database_name"  # Change to your database name
DB_USER="your_username"        # Change to your MySQL username
DB_PASS="your_password"        # Change to your MySQL password
BACKUP_DIR="/path/to/backup"   # Change to your desired backup directory
TIMESTAMP=$(date +"%F")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform the backup
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"

# Execute mysqldump and handle errors
if mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"; then
    echo "Backup of database '$DB_NAME' completed successfully."
    echo "Backup file: $BACKUP_FILE"
else
    echo "Error occurred while backing up the database '$DB_NAME'."
    exit 1
fi

# Optional: Remove backups older than 7 days
find "$BACKUP_DIR" -type f -name "*.sql" -mtime +7 -exec rm {} \;
echo "Old backups have been removed."

