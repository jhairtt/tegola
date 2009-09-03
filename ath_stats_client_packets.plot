set terminal x11
#set terminal postscript eps solid color
#set output "ath_stats_client_packets.eps"
set grid
set title ""
set autoscale
set datafile separator "|"
#set xdata time
#set timefmt "%Y-%m-%d %H:%M:%S"
set xlabel "Probe (count)"
set ylabel "Packets (count)"
plot "ath_stats_client.log.history.tmp" using 2:5 title "Packets" with steps lt 2

#plot "ath_stats_server.log.history.tmp" using 2:4 title "Output packets" with filledcurves,\
