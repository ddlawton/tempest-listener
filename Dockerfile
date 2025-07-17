FROM python:3.11-slim

WORKDIR /app
COPY tempest_listener.py .

# Store database in volume mount
VOLUME ["/data"]
ENV DB_PATH=/data/tempest.sqlite

CMD ["python", "tempest_listener.py"]
