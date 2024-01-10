#!/bin/bash
set -euo pipefail

CONFIG=$(sudo cat /sys/firmware/qemu_fw_cfg/by_name/gardenlinux-dev-image-user-config/raw)

if [[ -n $CONFIG ]]; then
    echo Installing user-config from "$CONFIG"
    sudo --user=dev git clone https://github.com/"$CONFIG" /home/dev/user-config
    if [[ -f /home/dev/user-config/config.sh ]]; then
        if [[ -x /home/dev/user-config/config.sh ]]; then
            sudo --user=dev /home/dev/user-config/config.sh
        fi
    fi
else
    echo No user config found
fi
