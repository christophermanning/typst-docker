#!/bin/sh
set -euo pipefail

function typst_compile() {
  file=$1
  echo -n "Compiling $file "
  typst compile $file
  echo -e "\xE2\x9C\x94"
}

# if an input argument is provided, just compile the requested file
if [ $# -ge 1 ]; then
  typst_compile $1
  exit 0
fi

echo -e "# Available Fonts"
typst fonts

# compile typst files on launch
echo -e "\n# Compiling Files"
for file in $(find . -name '*.typ'); do
  typst_compile $file
done

# watch all directories with *.typ files
dirs=$(find . -name '*.typ' -exec dirname "{}" \; | sort -u | sed 's/.*/\0\/*.typ/' | paste -sd' ')
echo -e "\n# Watching $dirs for Changes"

# incrementally compile changed files
# use poll_monitor because it's more reliable than inotify in docker mounted volumes
fswatch -0 --monitor=poll_monitor $dirs | xargs -0 -n1 -I{} sh -c 'watch.sh {}'
