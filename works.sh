#!/bin/sh

#N=$1

#for i in $(seq $N); do
CHANNEL=$(cat /root/channel)
echo "Measurement: $i"
echo "-->$CHANNEL"
case $CHANNEL in
    36)
         echo 165 > /root/channel
         ;;
     165)
         echo 36 > /root/channel
         ;;
 esac

scp channel root@10.3.0.1:/root/ -i /root/.ssh/id_rsa

echo "Setting channel at client..."
. /root/wl_channel.sh; CHANNEL=$(cat /root/channel); switch_to_channel ath3 $CHANNEL;  switch_to_channel ath3 $CHANNEL; echo $(current_channel ath3) $(current_width ath3)

echo "Setting channel at server..."
ssh root@10.3.0.1 -i /root/.ssh/id_rsa '. /root/wl_channel.sh; CHANNEL=$(cat /root/channel); switch_to_channel ath3 $CHANNEL; switch_to_channel ath3 $CHANNEL; echo $(current_channel ath3) $(current_width ath3)'

sleep 1

echo "Starting remote server..."

#begin measurement server
ssh root@10.3.0.1 -i /root/.ssh/id_rsa 'nohup /root/nuttcp-6.1.2 -S --nofork -1>>/root/test_udp_server.log;' &
sleep 1

#begin radiostats (server)
ssh root@10.3.0.1 -i /root/.ssh/id_rsa 'echo "---">> /root/radio_stats_server.log; echo $(date "+%F %T") >> /root/radio_stats_server.log; . /root/wl_channel.sh; echo "Channel " $(current_channel ath3)>>/root/radio_stats_server.log; /root/getRadioStatsLoop.sh >> /root/radio_stats_server.log&'

#Prepare log (client)
echo "---" >>/root/test_udp_client.log
echo $(date "+%F %T") >>/root/test_udp_client.log
. /root/wl_channel.sh
echo "Channel channel" $(current_channel ath3)>>/root/test_udp_client.log

#begin radio_stats (client)
echo "---" >>/root/radio_stats_client.log
echo $(date "+%F %T") >>/root/radio_stats_client.log
. /root/wl_channel.sh
echo "Channel " $(current_channel ath3)>>/root/radio_stats_client.log
/root/getRadioStatsLoop.sh >> radio_stats_client.log &

#begin athstats (client)
#(athstats -i wifi3 1 > /root/ath_stats_client.log)&

echo "Sleeping before injecting traffic..."

sleep 5

echo "---" >>/root/ping.log
echo $(date "+%F %T") >>/root/ping.log
. /root/wl_channel.sh
echo "Channel " $(current_channel ath3)>>/root/ping.log
ping -c 10 10.1.0.22 -s 1200 >> /root/ping.log
echo "Waking up..."

#begin measurement client
echo "Injecting traffic..."
#/root/nuttcp-6.1.2 -t -u -l1200 -i -Ri64m 10.1.0.22 >> test_udp_client.log
#Tue Aug 11 18:48:25 BST 2009: upgrade udp rate to 128
/root/nuttcp-6.1.2 -t -u -T20 -fxmitstats -fparse -l1460 -i -R64m 10.1.0.22 >> /root/test_udp_client.log

echo "Done."
#end measurement client

#end athstats (client)
#killall -9 athstats
#echo "---">> /root/ath_stats_client.log.history; echo $(date "+%F %T") >> /root/ath_stats_client.log.history; . /root/wl_channel.sh; echo "Channel " $(current_channel ath3)>>/root/ath_stats_client.log.history; cat /root/ath_stats_client.log >> /root/ath_stats_client.log.history;

#end radio_stats (client)
PID=$(ps aux | grep getRadioStatsLoop.sh |grep -v grep | sed 's/^ *//;s/ *$//' | cut -f1 -d' ')
kill -9 $PID

#end radio_stats (server)
ssh root@10.3.0.1 -i /root/.ssh/id_rsa 'killall -9 sh'

#done

exit 0
