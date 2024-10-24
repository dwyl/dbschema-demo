#!/bin/bash

# Get the container ID of the 'app' service
container_id=$(docker ps -qf "name=app")

if [ -z "$container_id" ]; then
  echo "App container is not running."
  exit 1
fi

echo "Monitoring container ID: $container_id"

# Set a timeout of 3 minutes (180 seconds)
timeout=180
elapsed=0

while [ $elapsed -lt $timeout ]; do
  # Check if the container is still running
  if ! docker ps -qf "id=$container_id" > /dev/null; then
    # Check the exit code of the container
    exit_code=$(docker inspect "$container_id" --format '{{.State.ExitCode}}')

    if [ "$exit_code" -eq 0 ]; then
      echo "App container exited successfully."
      exit 0
    else
      echo "App container exited with error. Exit code: $exit_code"
      exit 1
    fi
  fi

  # Wait for a second before checking again
  sleep 1
  ((elapsed++))
done

# If the container is still running after 3 minutes, exit with error
echo "App container did not exit within 3 minutes."
exit 1
