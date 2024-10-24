#!/bin/bash

# Timeout after 3 minutes (180 seconds)
TIMEOUT=180
START_TIME=$(date +%s)

# Loop to check the status of the app service
while true; do
    # Get the status of the app container
    STATUS=$(docker inspect --format='{{.State.Status}}' $(docker compose ps -q app))

    # If the container has exited, check the exit code
    if [ "$STATUS" == "exited" ]; then
        EXIT_CODE=$(docker inspect --format='{{.State.ExitCode}}' $(docker compose ps -q app))
        echo "App has exited with status: $EXIT_CODE"
        
        # If exit code is 0 (success), return success
        if [ "$EXIT_CODE" -eq 0 ]; then
            echo "App exited successfully."
            exit 0
        else
            echo "App failed with exit code: $EXIT_CODE"
            exit 1
        fi
    fi

    # Check if the timeout has been reached
    CURRENT_TIME=$(date +%s)
    ELAPSED_TIME=$((CURRENT_TIME - START_TIME))
    if [ "$ELAPSED_TIME" -gt "$TIMEOUT" ]; then
        echo "App did not exit within the timeout period (3 minutes)."
        exit 1
    fi

    # Wait a little before checking again
    sleep 5
done
