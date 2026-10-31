#!/bin/sh
set -eu
UUID="${UUID:-00000000-0000-0000-0000-000000000000}"
PORT="${PORT:-8080}"
WSPATH="${WSPATH:-/ws}"
case "$WSPATH" in /*) ;; *) WSPATH="/$WSPATH" ;; esac
cat > /tmp/c.json <<JSON
{"log":{"loglevel":"warning"},"inbounds":[{"listen":"0.0.0.0","port":${PORT},"protocol":"vless","settings":{"clients":[{"id":"${UUID}"}],"decryption":"none"},"streamSettings":{"network":"ws","security":"none","wsSettings":{"path":"${WSPATH}"}}}],"outbounds":[{"protocol":"freedom"}]}
JSON
exec /usr/local/bin/xray run -c /tmp/c.json
