#!/bin/bash

# available params:
#  name_internal
#  name_external
#  detailed_internal
#  detailed_external
MODE="$1"

# Get the monitor config
MONITOR_INTERNAL=$(grep -E '^monitor=(eDP|LVDS|DSI)' ~/.config/hypr/monitor-sources.conf | cut -d= -f2)
MONITOR_EXTERNAL=$(grep -E '^monitor=(HDMI|DP|DisplayPort|DVI-D|VGA|USB-C|NV)' ~/.config/hypr/monitor-sources.conf | cut -d= -f2)

if [[ "$MODE" == "name_internal" ]]; then
  echo "$MONITOR_INTERNAL" | cut -d, -f1
elif [[ "$MODE" == "name_external" ]]; then
  echo "$MONITOR_EXTERNAL" | cut -d, -f1
elif [[ "$MODE" == "detailed_internal" ]]; then
  echo "$MONITOR_INTERNAL"
elif [[ "$MODE" == "detailed_external" ]]; then
echo "$MONITOR_EXTERNAL"
else 
  echo "Invalid parameter"
fi
