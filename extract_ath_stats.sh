#!/bin/sh

sed 's/ \+/|/g;s/^|//g' ath_stats_client.log.history | awk -F "|" 'BEGIN{OFS="|";total=0} (($2<1000 && $2>0 && $1<1000 && $1>0) || $1=="2009-08-09" || $1=="2009-08-10" || $1=="2009-08-11" || $1=="Channel" || $1=="---"){if ($1=="2009-08-09"  || $1=="2009-08-10" || $1=="2009-08-11") {cd=$1;ct=$2;row=-1} if ($1=="Channel") {w=$3} print cd " " ct "."  row++ "|" total++ "|" w "|" $1 "|" $2 "|" $3 "|" $4 "|" $5 "|" $6 "|" $7}' | grep -v "Channel" | grep -v "||||" > ath_stats_client.log.history.tmp


exit 0
