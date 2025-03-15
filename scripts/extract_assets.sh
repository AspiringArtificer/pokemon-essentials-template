#!/bin/bash

SOURCE="../src/essentials"
TARGET="../src/assets"

# Find scripts directory
SCRIPT_SOURCE=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_SOURCE" ]; do # resolve $SCRIPT_SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )
  SCRIPT_SOURCE=$(readlink "$SCRIPT_SOURCE")
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE=$DIR/$SCRIPT_SOURCE # if $SCRIPT_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )

# Find and copy files ignored by essentials
pushd $DIR/$SOURCE
readarray -t asset_files < <(git ls-files --others --ignored --exclude-standard)
for item in "${asset_files[@]}"; do
  if [[ "${item##*.}" == "rxdata" ]]; then
    # if [[ "$item" == *"Scripts.rxdata"* ]]; then
    #   cp --update --parents "$item" "$DIR/$TARGET"
    # fi
    echo "skipping $item"
  elif  [[ "${item##*.}" == "dat" ]]; then
    echo "skipping $item"
  else
    cp --update --parents "$item" "$DIR/$TARGET"
    rc=$?
    if [ $rc -ne 0 ]; then
      echo "$item failed to copy"
    fi
  fi
done
popd
