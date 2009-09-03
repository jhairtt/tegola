set terminal x11
#set terminal postscript solid eps color
#set output "packet_loss.eps"
#set title "Target"
#set autoscale
set key box
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
#set xrange ["2009-08-06 16:00:00":"2009-08-08 07:00:00"]
set grid
set xlabel "Time (hour)"
#set ylabel "Throughput (Mbps)"
plot "test_udp_client.log.throughput" using 1:6 title "UDP packets dropped" with filledcurves x1,\
     "test_udp_client.log.throughput" using 1:6:7 title "UDP packets sent" with filledcurves
     