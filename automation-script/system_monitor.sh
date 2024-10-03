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

# Run the function
check_usage

