#!/bin/sh

egrep '(^2009|^Channel|  =>ath3)' radio_stats_client.log.new | awk '{printf $0;printf " "}NR % 3 ==0 {print " "}'  | sed 's/ Channel width /|/g;s/  =>ath3: 0004//g' > t
cut -f1 -d'|' t > d
cut -f2 -d'|' t |sed 's/ \+/|/g' | cut -f1,2,3,4 -d'|' > m
paste -d'|' d m > radio_stats_client.log.tmp

grep '|5|' radio_stats_client.log.tmp > radio_stats_client.log.tmp.5
grep '|10|' radio_stats_client.log.tmp > radio_stats_client.log.tmp.10
grep '|20|' radio_stats_client.log.tmp > radio_stats_client.log.tmp.20

egrep '(^2009|^Channel|  =>ath3)' radio_stats_server.log.new | awk '{printf $0;printf " "}NR % 3 ==0 {print " "}'  | sed 's/ Channel width /|/g;s/  =>ath3: 0004//g' > t
cut -f1 -d'|' t > d
cut -f2 -d'|' t |sed 's/ \+/|/g' | cut -f1,2,3,4 -d'|' > m
paste -d'|' d m > radio_stats_server.log.tmp

rm -f d t m

grep '|5|' radio_stats_server.log.tmp > radio_stats_server.log.tmp.5
grep '|10|' radio_stats_server.log.tmp > radio_stats_server.log.tmp.10
grep '|20|' radio_stats_server.log.tmp > radio_stats_server.log.tmp.20

exit 0