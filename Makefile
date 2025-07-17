# Variables
IMAGE_NAME=tempest-sqlite-listener
CONTAINER_NAME=tempest_listener
VOLUME_PATH=$(HOME)/SideProjects/tempest-listener/data

# Default target
.PHONY: help
help:
	@echo "Makefile commands:"
	@echo "  make build       - Build the Docker image"
	@echo "  make run         - Run the container (detached)"
	@echo "  make debug       - Run the container interactively with shell"
	@echo "  make clean       - Remove the Docker image"
	@echo "  make stop        - Stop the running container"
	@echo "  make rm          - Remove the container"
	@echo "  make logs        - Show container logs"
	@echo "  make restart     - Restart the container"

# Build the Docker image
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# Run the container normally
.PHONY: run
run:
	docker run -d \
		--name $(CONTAINER_NAME) \
		--restart unless-stopped \
		--net=host \
		-v $(VOLUME_PATH):/data \
		$(IMAGE_NAME)

# Interactive debugging shell (drops you into the container)
.PHONY: debug
debug:
	docker run --rm -it \
		--net=host \
		-v $(VOLUME_PATH):/data \
		$(IMAGE_NAME) /bin/bash || /bin/sh

# Remove the Docker image
.PHONY: clean
clean:
	docker rmi -f $(IMAGE_NAME)

# Stop and remove the container
.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)

.PHONY: rm
rm:
	docker rm $(CONTAINER_NAME)

# Show logs
.PHONY: logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Restart container
.PHONY: restart
restart:
	docker restart $(CONTAINER_NAME)
