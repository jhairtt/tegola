set terminal x11
#set terminal postscript eps solid color
#set output "ath_stats_client_retransmissions.eps"
set grid
set title ""
set autoscale
set datafile separator "|"
#set xdata time
#set timefmt "%Y-%m-%d %H:%M:%S"
set xlabel "Probe (count)"
set ylabel "Retransmissions (count)"
plot "ath_stats_client.log.history.tmp" using 2:8 title "Retries" with steps lt 3
     

#plot "ath_stats_server.log.history.tmp" using 2:4 title "Output packets" with filledcurves,\
