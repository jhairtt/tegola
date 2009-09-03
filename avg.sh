#!/bin/sh

cut -f1,2 -d'|' radio_stats_client.log.tmp.5 >x
cut -f3-200 -d'|' radio_stats_client.log.tmp.5 | sed 's/|/\t/g' >y
./avg.pl 10  < y > a
sed 's/ \+/|/g' a > y
paste -d'|' x y > radio_stats_client.log.tmp.5.avg

cut -f1,2 -d'|' radio_stats_client.log.tmp.10 >x
cut -f3-200 -d'|' radio_stats_client.log.tmp.10 | sed 's/|/\t/g' >y
./avg.pl 10  < y > a
sed 's/ \+/|/g' a > y
paste -d'|' x y > radio_stats_client.log.tmp.10.avg

cut -f1,2 -d'|' radio_stats_client.log.tmp.20 >x
cut -f3-200 -d'|' radio_stats_client.log.tmp.20 | sed 's/|/\t/g' >y
./avg.pl 10  < y > a
sed 's/ \+/|/g' a > y
paste -d'|' x y > radio_stats_client.log.tmp.20.avg


cut -f1,2 -d'|' radio_stats_server.log.tmp.5 >x
cut -f3-200 -d'|' radio_stats_server.log.tmp.5 | sed 's/|/\t/g' >y
./avg.pl 10  < y > a
sed 's/ \+/|/g' a > y
paste -d'|' x y > radio_stats_server.log.tmp.5.avg

cut -f1,2 -d'|' radio_stats_server.log.tmp.10 >x
cut -f3-200 -d'|' radio_stats_server.log.tmp.10 | sed 's/|/\t/g' >y
./avg.pl 10  < y > a
sed 's/ \+/|/g' a > y
paste -d'|' x y > radio_stats_server.log.tmp.10.avg

cut -f1,2 -d'|' radio_stats_server.log.tmp.20 >x
cut -f3-200 -d'|' radio_stats_server.log.tmp.20 | sed 's/|/\t/g' >y
./avg.pl 10  < y > a
sed 's/ \+/|/g' a > y
paste -d'|' x y > radio_stats_server.log.tmp.20.avg
