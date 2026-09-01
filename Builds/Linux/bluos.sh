#!/bin/sh
printf '\033c\033]0;%s\a' Welcome To BluOS
base_path="$(dirname "$(realpath "$0")")"
"$base_path/bluos.x86_64" "$@"
