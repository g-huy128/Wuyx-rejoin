#!/bin/bash
cd
if [ -e "/data/data/com.termux/files/home/storage" ]; then
	rm -rf /data/data/com.termux/files/home/storage
fi
termux-setup-storage
yes | pkg update


source "/data/data/com.termux/files/usr/bin/termux-setup-package-manager" || exit 1

MIRROR_BASE_DIR="/data/data/com.termux/files/usr/etc/termux/mirrors"

unlink_and_link() {
    MIRROR_GROUP="$1"
    if [ -L "/data/data/com.termux/files/usr/etc/termux/chosen_mirrors" ]; then
        unlink "/data/data/com.termux/files/usr/etc/termux/chosen_mirrors"
    fi
    ln -s "${MIRROR_GROUP}" "/data/data/com.termux/files/usr/etc/termux/chosen_mirrors"
}

select_repository_group() {
    unlink_and_link ${MIRROR_BASE_DIR}/all
}

if ! command -v apt 1>/dev/null; then
    echo "Error: Cannot change mirrors since apt is not installed." >&2
    exit 1
fi

if [ "$TERMUX_APP_PACKAGE_MANAGER" = "pacman" ]; then
    read -p "Warning: termux-change-repo can only change mirrors for apt, is that what you intended? [y|n] " -n 1 -r
    echo
    [[ ${REPLY} =~ ^[Nn]$ ]] && exit
fi

mkdir -p "/data/data/com.termux/files/usr/tmp" || exit $?

select_repository_group

echo "[*] pkg --check-mirror update"
TERMUX_APP_PACKAGE_MANAGER=apt pkg --check-mirror update


yes | pkg upgrade
yes | pkg i python
yes | pkg i python-pip
pip install requests   pytz  colorama datetime
export CFLAGS="-Wno-error=implicit-function-declaration"
pkg install python-psutil -y

curl -Ls "https://raw.githubusercontent.com/g-huy128/Wuyx-rejoin/refs/heads/main/obf-wuyx_rejoin.py" -o /sdcard/Download/obf-wuyx_rejoin.py
