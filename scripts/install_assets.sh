#!/bin/bash

SOURCE="../src/assets"
TARGET="../src/essentials"

# Find scripts directory
SCRIPT_SOURCE=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_SOURCE" ]; do # resolve $SCRIPT_SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )
  SCRIPT_SOURCE=$(readlink "$SCRIPT_SOURCE")
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE=$DIR/$SCRIPT_SOURCE # if $SCRIPT_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )

# Copy in the asset files
pushd $DIR/$SOURCE
readarray -t asset_files < <(git ls-files --others --ignored --exclude-standard)
asset_files=("Audio" "Graphics" "Plugins" "Game.ini" "Game.rxproj")
for item in "${asset_files[@]}"; do
    if [ -e "$item" ]; then
        echo "installing $item..."
        cp --recursive --update --parents "$item" "$DIR/$TARGET"
        rc=$?
        if [ $rc -ne 0 ]; then
            echo "$item failed to copy"
        fi
    fi
done
popd