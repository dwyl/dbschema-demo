#!/bin/bash

# Get the container ID of the app service
container_id=$(docker ps -qf "name=app")

if [ -z "$container_id" ]; then
  echo "Error: Could not find the app container. It may not have started."
  exit 1
fi

# Start a timer
start_time=$(date +%s)

# Loop until the app exits successfully or 3 minutes have passed
while true; do
  # Check if the container is still running
  if ! docker ps -qf "id=$container_id"; then
    echo "App container is no longer running. Exiting."
    break
  elif [ -z "$(docker ps -qf "id=$container_id")" ]; then
    echo "App container had already exited. Exiting the loop."
    exit 1
  fi

  # Check if 3 minutes have passed
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))

  if [ "$elapsed_time" -ge 180 ]; then
    echo "App is still running after 3 minutes. Exiting with timeout error."
    exit 1
  fi

  # Sleep for a few seconds before checking again
  sleep 5
done

exit 0
