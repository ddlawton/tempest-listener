# Tempest SQLite Listener

This project listens for UDP broadcast messages from a **Tempest Weather Station Hub** on port `50222` and stores the decoded data in a local **SQLite database**.

Ideal for running 24/7 on a **TrueNAS SCALE** box or any Linux system with Docker support.

---

## Features

- Listens to UDP broadcasts from your Tempest Hub
- Decodes incoming JSON payloads
- Persists structured weather data into `tempest.sqlite`
- Lightweight and persistent — no API keys required

---

## Getting Started

### 1. Clone this repository

```bash
git clone https://github.com/ddlawton/tempest-listener.git
cd tempest-listener
```

### 2. build and run docker image

```bash
make build

make run
```

This runs the container in the background with:

- Host networking (--net=host) to receive UDP broadcasts
- A local ./data/ folder mounted to /data inside the container

### 3. verify its running as expected

```bash
make logs
```

You should see messages like:

```bash
Saved obs_st: timestamp=1721179196, temp=22.9, ...
```

## Makefile commands

| Command        | Description                          |
| -------------- | ------------------------------------ |
| `make build`   | Build the Docker image               |
| `make run`     | Run the container in the background  |
| `make debug`   | Run container with interactive shell |
| `make logs`    | View container logs (live output)    |
| `make stop`    | Stop the container                   |
| `make rm`      | Remove the container                 |
| `make clean`   | Delete the Docker image              |
| `make restart` | Restart the container                |


## Requirements

- A Tempest Weather Hub on your local network

- TrueNAS SCALE or any Linux system with:
    - Docker
    - --net=host networking mode enabled

- Your Tempest Hub must be broadcasting UDP to 255.255.255.255:50222

## Data output

```bash
./data/tempest.sqlite
```
