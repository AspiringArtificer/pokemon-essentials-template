#!/bin/bash

ESSENTIALS_PATH="../src/essentials"

# Find scripts directory
SCRIPT_SOURCE=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_SOURCE" ]; do # resolve $SCRIPT_SOURCE until the file is no longer a symlink
  DIR=$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)
  SCRIPT_SOURCE=$(readlink "$SCRIPT_SOURCE")
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE=$DIR/$SCRIPT_SOURCE # if $SCRIPT_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)

# Start of Script

pushd "$DIR/.."
readarray -t arr < <(yq e '.file_list[]' eevee.yaml)
popd

pushd "$DIR/$ESSENTIALS_PATH/Data"
for item in "${arr[@]}"; do
  rm -f $item
done

rm -f Map*.rxdata
rm -f Tilesets.rxdata
rm -f PkmnAnimations.rxdata
rm -f PluginScripts.rxdata
for file in *.dat; do
  if ! [[ "${file}" == messages_core.dat ]]; then
    rm -f ${file}
  fi
done
popd
