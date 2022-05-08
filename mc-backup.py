#!/usr/bin/env python3

from argparse import ArgumentParser
from datetime import datetime, timezone
import os
import pathlib
import tarfile
from typing import Generator


def __timestamp() -> str:
    'date_time, e.g. 20220508_222245'
    return datetime.now().astimezone(timezone.utc).strftime("%Y%m%d_%H%M%S")

def __bytes_to_mb_human(n_bytes: int) -> str:
    return f"{n_bytes/float(1<<20):,.0f} MB"

def __iter_dir(dirpath: str) -> Generator[str, None, None]:
    for f in pathlib.Path(dirpath).glob("**/*"):
        if f.is_file():
            yield os.path.abspath(f)

def __dir_byte_size_recursive(dirpath: str) -> int:
    return sum(f.stat().st_size for f in pathlib.Path(dirpath).glob("**/*") if f.is_file())



def compress_dir(idirpath: str, ofpath: str) -> None:
    os.makedirs(os.path.dirname(ofpath), exist_ok=True)

    with tarfile.open(ofpath, "w:gz") as ostream:
        for f in __iter_dir(idirpath):
            print(f"  . {f}")
            ostream.add(f)

def run(target_dir: str, backup_dir: str, force: bool = False) -> None:
    dest_dir = os.path.join(backup_dir, target_dir)
    dest_fpath = os.path.join(dest_dir, f"{__timestamp()}.tar.gz")

    print(
        f"- Target ({__bytes_to_mb_human(__dir_byte_size_recursive(target_dir))}): {target_dir}\n"
        f"- Destination: {dest_fpath}\n"
        "  Seem legit? "
    )
    if not force:
        input()

    compress_dir(target_dir, dest_fpath)

    print(f"- backup successful ({__bytes_to_mb_human(os.path.getsize(dest_fpath))}): {dest_fpath}")


def parse_args() -> dict:
    parser = ArgumentParser(description='Backup a minecraft folder as a tarball (.tar.gz)')
    parser.add_argument('-target-dir',  type=str, help='the minecraft dir to backup')
    parser.add_argument('-backup-dir',  type=str, help='the dir to store the backups in')
    parser.add_argument('-force',       type=bool, help='skips confirmation message',  default=False)
    return parser.parse_args().__dict__

if __name__ == "__main__":
    run(**parse_args())
