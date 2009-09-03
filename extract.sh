#!/bin/sh

egrep '(^2009|^Channel|real_seconds)' test_udp_client.log | awk '{printf $0;printf " "}NR % 3 ==0 {print " "}' | cut -d'=' -f1,4,5,6,7,8,10 | sed 's/ Channel width /|/g;s/ megabytes=/|/g;s/tx_cpu//g;s/ =/|/g;s/ rx_cpu/|/g;s/=/|/g;s/ drop/|/g;s/ pkt//g;s/ data_loss//g;s/||/|/g' > test_udp_client.log.throughput

awk -F "|" 'BEGIN{OFS="|"} ($3<50 && $2==5)' test_udp_client.log.throughput > test_udp_client.log.throughput.5
awk -F "|" 'BEGIN{OFS="|"} ($3<50 && $2==10)' test_udp_client.log.throughput > test_udp_client.log.throughput.10
awk -F "|" 'BEGIN{OFS="|"} ($3<50 && $2==20)' test_udp_client.log.throughput > test_udp_client.log.throughput.20

grep -v "  ath3: 0004    0." radio_stats_client.log > radio_stats_client.log.new

#
# At this point use the following search/replace in emacs (probably
# can be done with sed too (also replace Channel width 5, Channel
# width 20, accordingly).
#
# Channel width.*^J  ath3: -> Channel width.*^J  =>ath3:
# 
# Then save radio_stats_client.log.new in emacs and call
# extract_radio_stats.sh with radio_stats_client.log.new as first
# parameter.


#
# (Do the same for radio_stats_server.log)
#
grep -v "  ath3: 0004    0." radio_stats_server.log > radio_stats_server.log.new


exit 0