#!/bin/sh

while [ 1 ]; do
    cat /proc/net/wireless | grep ath3 | grep -v 256
     
    sleep 1
done