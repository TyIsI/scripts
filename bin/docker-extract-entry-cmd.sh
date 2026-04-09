#!/usr/bin/env bash

# From: https://techoverflow.net/2025/09/02/how-to-extract-the-entrypoint-and-command-of-a-docker-container-image/
# Original Author: @ulikoehler https://github.com/ulikoehler
# Improvements by @TyIsI

if [ "$1" = "" ] ; then
	echo "Missing image"
	exit 255
fi

TARGETS=""

for ARG in "${@}" ; do
    if [ "${ARG}" = "--json" ] ; then
        JSON_OUTPUT="yes"
    else
        TARGETS="${TARGETS} ${ARG}"
    fi
done

for TARGET in ${TARGETS} ; do
    if [ "${JSON_OUTPUT:-no}" = "yes" ] ; then
        docker inspect "${TARGET}" --format='{"entrypoint":{{json .Config.Entrypoint}},"cmd":{{json .Config.Cmd}}}'
    else
        docker inspect "${TARGET}" --format='ENTRYPOINT: {{.Config.Entrypoint}} CMD: {{.Config.Cmd}}'
    fi
done
