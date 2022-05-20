#/bin/bash

set -euo pipefail

docker pull itzg/minecraft-server:latest
docker run \
  --name mc3 \
  -d \
  --restart=unless-stopped \
  -p 25567:25565 \
  -e VERSION=1.18.2 \
  -e EULA=TRUE \
  -e TYPE=FABRIC \
  -v /home/freman/.minecraft-creative3/:/data \
  itzg/minecraft-server:latest
