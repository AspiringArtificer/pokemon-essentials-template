#!/bin/bash

CONVERTER="../tools/autotile-converter/xp-autotile.py"
ASSETS_PATH="../src/assets"
AUTOTILES_PATH="Graphics/Autotiles"

# Find scripts directory
SCRIPT_SOURCE=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_SOURCE" ]; do # resolve $SCRIPT_SOURCE until the file is no longer a symlink
  DIR=$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)
  SCRIPT_SOURCE=$(readlink "$SCRIPT_SOURCE")
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE=$DIR/$SCRIPT_SOURCE # if $SCRIPT_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)

# Start of Script

for file_path in $DIR/$ASSETS_PATH/$AUTOTILES_PATH/*; do
  if [ -f "${file_path}" ]; then
    file=$(basename "${file_path}")
    output="$DIR/$ASSETS_PATH/Tiled/$AUTOTILES_PATH/$file"
    if ! [ -f "${output}" ] || [[ "$1" == "force" ]]; then
      echo converting "$file"...
      python $DIR/$CONVERTER to_tiled "$DIR/$ASSETS_PATH/$AUTOTILES_PATH/$file" "$output"
    fi
  fi
done
