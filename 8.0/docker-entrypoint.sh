#!/bin/bash

set -e

# first check if we're passing flags, if so
# prepend with sentry
if [ "${1:0:1}" = '-' ]; then
	set -- sentry "$@"
fi

case "$1" in
	celery|cleanup|config|createuser|devserver|django|export|help|import|init|repair|shell|start|upgrade)
		set -- sentry "$@"
	;;
esac

if [ "$1" = 'sentry' ]; then
	if [ ! -f "$SENTRY_CONF/sentry.conf.py" ]; then
		sentry init "$SENTRY_CONF"
	fi
fi

exec "$@"
