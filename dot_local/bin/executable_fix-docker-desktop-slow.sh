#!/bin/bash

echo "run $0"
exit 0

if ! command -v docker-credential-desktop.exe &>/dev/null; then
    exit 0
fi

# avoid https://github.com/docker/for-win/issues/10247
echo "delete credsStore key to ignore docker-credential-desktop.exe hangs..."

if [ ! -f ~/.docker/config.json ]; then
    exit 0
fi

if ! grep "credsStore" ~/.docker/config.json >/dev/null 2>&1; then
    exit 0
fi

cat ~/.docker/config.json | jq -r 'del('.credsStore')' >/tmp/fixed-docker-config.json
mv -f /tmp/fixed-docker-config.json ~/.docker/config.json
