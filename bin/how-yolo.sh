#!/usr/bin/env bash

if [ "$*" = "" ] ; then
	echo NO YOLO WITHOUT SAUCE BITS!
	exit 255
fi

SAUCEYBITS=$@

for SAUCE in ${SAUCEYBITS} ; do
	if [ ! -d "${SAUCE}" ] ; then
		echo AAAAAAAAAAAAH NO SAUCE IN ${SAUCE} NEWB
		exit 254
	fi
done

grep -cwr YOLO ${SAUCEYBITS} | cut -f2 -d: | awk '{sum += $1;}; END { print sum }'
