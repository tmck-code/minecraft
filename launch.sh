#!/bin/bash

set -euo pipefail

docker pull itzg/minecraft-server:latest
docker run \
  --name mc \
  -d \
  --restart=unless-stopped \
  -p 25565:25565 \
  -e VERSION=1.17.1 \
  -e TYPE=FABRIC \
  -e EULA=TRUE \
  -v /home/freman/.minecraft-creative/:/data \
  itzg/minecraft-server:latest
