#!/bin/bash

echo "[*] Stopping and removing vulnerable container..."
docker stop apache-vuln 2>/dev/null
docker rm apache-vuln 2>/dev/null

echo "[*] Building patched image..."
docker build -f Dockerfile.patched -t apache-patched .

echo "[*] Running secure container..."
docker run -dit -p 8080:80 --name apache-secure apache-patched

echo "[+] Patched Apache running on http://localhost:8080"
