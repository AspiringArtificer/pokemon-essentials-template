#!/bin/bash
file=$1

echo "event(" > "${file}"
echo "  id: $2," >> "${file}"
echo '  name: "'${3}'",' >> "${file}"
echo "  x: $4," >> "${file}"
echo "  y: $5," >> "${file}"
echo ")" >> "${file}"