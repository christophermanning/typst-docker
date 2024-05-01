#!/bin/sh
set -euo pipefail

echo -e "# Available Fonts"
typst fonts

# compile typst files on launch
echo -e "\n# Compiling Files"
ls *.typ
typst compile *.typ

# incrementally compile changed files
# use poll_monitor because it's more reliable than inotify in docker mounted volumes
echo -e "\n# Watching $(pwd)/*.typ for Changes"
fswatch -0 --monitor=poll_monitor *.typ | xargs -0 -n1 -I{} echo "Compiling {}" && typst compile "{}"
