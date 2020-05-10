#!/bin/bash
set -eo pipefail

DOZZLE_TAILSIZE="${DOZZLE_TAILSIZE:-1000}"
DOZZLE_FILTER="${DOZZLE_FILTER:-}"
DOZZLE_WEBBASE="${DOZZLE_WEBBASE:-/}"
DOZZLE_PORT="${DOZZLE_PORT:-$PORT}"

# If command starts with an option, prepend dozzle
if [ "${1:0:1}" = '-' ]
then
    set -- dozzle "$@"
fi

if [ "${1}" == "dozzle" ]
then
    CMD="$@ --addr :${DOZZLE_PORT}"
    [ -n "${DOZZLE_TAILSIZE}" ] && CMD="${CMD} --tailSize ${DOZZLE_TAILSIZE}"
    [ -n "${DOZZLE_FILTER}" ] && CMD="${CMD} --filter ${DOZZLE_FILTER}"
    [ -n "${DOZZLE_WEBBASE}" ] && CMD="${CMD} --base ${DOZZLE_WEBBASE}"

    exec ${CMD}
else
    exec "$@"
fi

