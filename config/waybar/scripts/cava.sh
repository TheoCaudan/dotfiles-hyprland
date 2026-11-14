#!/usr/bin/env bash

pkill -9 -x cava 2>/dev/null || true

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

i=0
while [ $i -lt ${#bar} ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i = i + 1))
done

config_file="/tmp/waybar_cava_config"
cat << 'EOF' > "$config_file"
[general]
bars = 10

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

trap "pkill -9 -x cava 2>/dev/null; rm -f $config_file; exit 0" EXIT INT TERM

cava -p $config_file | while read -r line; do
  echo $line | sed $dict
done
