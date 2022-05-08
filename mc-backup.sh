#!/bin/bash

set -euxo pipefail

target_dir="$1"
backup_dir="${2}"

# date_time, e.g. 20220508_222245
timestamp=$(date +%Y%m%d_%H%M%S)

mkdir -p "${backup_dir}/${target_dir}/"

tar czvf "${backup_dir}/${target_dir}/${timestamp}.tar.gz" "${target_dir}"
