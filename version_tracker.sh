#!/bin/bash

URL="https://tetr.io/js/tetrio.js"
LOG_FILE="tetrio_change.log"
HASH_FILE="tetrio_hash"

sleepTime=3600
sleepTime=10

while true; do
    date=$(date +%Y-%m-%d)
    file=$(curl -s "$URL")
    hash=$(echo "$file" | shasum -a 256)

    if [ -f "$HASH_FILE" ]; then
        last_hash=$(cat "$HASH_FILE")
        if [ "$hash" != "$last_hash" ]; then
            echo "$hash" > "$HASH_FILE"
            echo "Updated $(date)" >> "$LOG_FILE"
            sleepTime=600

            echo "GAME UPDATED!!!"
        else
            # set sleepTime 5 min more than last time, but capped at 1 hour
            sleepTime=$((sleepTime + 300))
            if [ $sleepTime -gt 3600 ]; then
                sleepTime=3600
            fi
            echo "No changes detected"
        fi
    else
        echo "$hash" > "$HASH_FILE"
        echo "Initialized $(date)" >> "$LOG_FILE"
        mkdir -p backup_versions
        echo "$file" > "backup_versions/tetrio$date.js"
        sleepTime=3600

        echo "Initialized"
    fi

    if [ "$1" != "--server" ]; then
        echo "No --server flag provided, exiting..."
        exit 0
    fi

    echo "sleeping for $sleepTime seconds..."
    sleep $sleepTime
done
