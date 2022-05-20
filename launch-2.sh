#/bin/bash

set -euo pipefail

docker pull itzg/minecraft-server:latest
docker run \
  --name mc2 \
  -d \
  --restart=unless-stopped \
  -p 25566:25565 \
  -e VERSION=1.17.1 \
  -e EULA=TRUE \
  -e TYPE=FABRIC \
  -v /home/freman/.minecraft-creative2/:/data \
  itzg/minecraft-server:latest
