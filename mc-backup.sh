#!/bin/bash

set -euo pipefail

target_dir="${1:-}"
backup_dir="${2:-}"

if [ -z "$backup_dir" ] || [ -z "$target_dir" ]; then
  echo "\
Usage: mc-backup.sh <target-dir> <backup-dir>

e.g. This command will produce the following backup file

command: mc-backup.sh .minecraft-creative /mnt/drive/minecraft-backups/
backup:  /mnt/drive/minecraft-backups/.minecraft-creative/20220201_100341.tar.gz
"
fi

# date_time, e.g. 20220508_222245
timestamp=$(date +%Y%m%d_%H%M%S)
dest_dir="$backup_dir/$target_dir"
dest_fpath="$dest_dir/$timestamp.tar.gz"

du -sH "$target_dir"

echo "- from: $target_dir"
echo "- to: $dest_dir"
echo "- backup: $dest_fpath"

printf '\n  seem legit?'
read -r

mkdir -p "$dest_dir"
tar czf "$dest_fpath" "$target_dir"

ls -alh "$dest_fpath"
echo "- backup successful: $dest_fpath"
