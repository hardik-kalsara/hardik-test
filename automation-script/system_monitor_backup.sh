#!/bin/bash

# Function to check CPU and Memory usage
check_usage() {
    echo "=== CPU and Memory Usage ==="
    
    # Check CPU usage
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
    
    # Check Memory usage
    echo "Memory Usage:"
    free -h | awk '/^Mem/ {print $3 "/" $2 " (" $3/$2*100 "%)"}'
    
    echo
    echo "=== Top 5 CPU Consuming Processes ==="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo
    echo "=== Top 5 Memory Consuming Processes ==="
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo
}

# Function to backup MySQL database
backup_mysql() {
    DB_NAME="your_database_name"  # Change to your database name
    DB_USER="your_username"        # Change to your MySQL username
    DB_PASS="your_password"        # Change to your MySQL password
    BACKUP_DIR="/path/to/backup"   # Change to your desired backup directory
    TIMESTAMP=$(date +"%F")

    # Create backup directory if it doesn't exist
    mkdir -p "$BACKUP_DIR"

    # Perform the backup
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"

    if [ $? -eq 0 ]; then
        echo "Backup of database '$DB_NAME' completed successfully."
    else
        echo "Error occurred while backing up the database '$DB_NAME'."
    fi
}

# Run the functions
check_usage
backup_mysql

