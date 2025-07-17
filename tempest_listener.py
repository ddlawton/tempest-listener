import socket
import json
import sqlite3
from datetime import datetime
import os

DB_PATH = os.environ.get("DB_PATH", "data/tempest.sqlite")

# Setup UDP listener
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('', 50222))

# Setup SQLite
os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
conn = sqlite3.connect(DB_PATH)
cur = conn.cursor()
cur.execute("""
CREATE TABLE IF NOT EXISTS weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    received_at TEXT,
    station_id TEXT,
    type TEXT,
    payload TEXT
)
""")
conn.commit()

print("Listening for Tempest UDP packets on port 50222...")

while True:
    data, _ = sock.recvfrom(4096)
    try:
        payload = json.loads(data.decode())
        cur.execute(
            "INSERT INTO weather (received_at, station_id, type, payload) VALUES (?, ?, ?, ?)",
            (
                datetime.utcnow().isoformat(),
                payload.get("station_id", "unknown"),
                payload.get("type", "unknown"),
                json.dumps(payload)
            )
        )
        conn.commit()
    except Exception as e:
        print("Error parsing/inserting:", e)