#!/usr/bin/env bash

cat - | xargs -r -I% wget -N '%'
