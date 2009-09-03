#set terminal x11
set terminal postscript eps solid color
set output "ath_stats_client_packets_ZOOM.eps"
set grid
set title ""
set autoscale
set datafile separator "|"
#set xdata time
#set timefmt "%Y-%m-%d %H:%M:%S"
set xrange [4998:5316]
set xlabel "Probe"
set ylabel "Count"
plot "ath_stats_client.log.history.tmp" using 2:5 title "Packets" with steps lt 2,\
     "ath_stats_client.log.history.tmp" using 2:8 title "Retransmissions" with steps lt 3



#plot "ath_stats_server.log.history.tmp" using 2:4 title "Output packets" with filledcurves,\
