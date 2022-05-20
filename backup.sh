#!/bin/bash

set -euo pipefail

SOURCE_DIR="$1"
BACKUP_DIR="$2"
DOCKER_NAME="$3"
BACKUP="$SOURCE_DIR.$(date +%Y%m%d_%H%M%S).tar.gz"

docker stop "$DOCKER_NAME"

tar czvf "$BACKUP"  "$SOURCE_DIR"
rsync -av --progress "$BACKUP" "$BACKUP_DIR"
rm "$BACKUP"

docker start "$DOCKER_NAME"
