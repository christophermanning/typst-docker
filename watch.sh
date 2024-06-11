#!/bin/sh
set -euo pipefail

echo -e "# Available Fonts"
typst fonts

# compile typst files on launch
echo -e "\n# Compiling Files"
for file in $(find . -name '*.typ'); do
  echo -n "$file "
  typst compile $file
  echo -e "\xE2\x9C\x94"
done

# incrementally compile changed files
# use poll_monitor because it's more reliable than inotify in docker mounted volumes
dirs=$(find . -name '*.typ' -exec dirname "{}" \; | sort -u | sed 's/.*/\0\/*.typ/' | paste -sd' ')
echo -e "\n# Watching $dirs for Changes"
fswatch -0 --monitor=poll_monitor $dirs | xargs -0 -n1 -I{} sh -c 'echo -n "Compiling {} " && typst compile "{}" && echo -e "\xE2\x9C\x94"'
