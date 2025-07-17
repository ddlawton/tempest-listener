#!/bin/bash

IMAGE_NAME="tempest-sqlite-listener"
CONTAINER_NAME="tempest_listener"
VOLUME_PATH="/mnt/NAS/tempest_data"

function build() {
  echo "Building Docker image..."
  docker build -t $IMAGE_NAME .
}

function run() {
  echo "Running container..."
  docker run -d \
    --name $CONTAINER_NAME \
    --restart unless-stopped \
    --net=host \
    -v $VOLUME_PATH:/data \
    $IMAGE_NAME
}

function stop() {
  echo "Stopping container..."
  docker stop $CONTAINER_NAME
}

function rm() {
  echo "Removing container..."
  docker rm $CONTAINER_NAME
}

function logs() {
  echo "Showing container logs..."
  docker logs -f $CONTAINER_NAME
}

function help() {
  echo "Usage: $0 {build|run|stop|rm|logs|help}"
  echo "Commands:"
  echo "  build  - Build the Docker image"
  echo "  run    - Run the container (detached)"
  echo "  stop   - Stop the running container"
  echo "  rm     - Remove the container"
  echo "  logs   - Tail container logs"
  echo "  help   - Show this help message"
}

if [ $# -eq 0 ]; then
  help
  exit 1
fi

case "$1" in
  build) build ;;
  run) run ;;
  stop) stop ;;
  rm) rm ;;
  logs) logs ;;
  help) help ;;
  *) echo "Invalid command: $1"; help; exit 1 ;;
esac