#!/bin/bash

cat - | xargs -r -I% wget -N '%'
