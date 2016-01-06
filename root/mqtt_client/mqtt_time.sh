#!/bin/sh
OFFSET=$(date +%z)
SIGN=${OFFSET:0:1}
HOURS=${OFFSET:1:2}
MINUTES=${OFFSET:3:2}
EPOCH=$(date +%s)
echo $(( ${EPOCH} ${SIGN} ( ${HOURS} * 3600 + ${MINUTES} * 60 ) ))