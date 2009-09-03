set terminal x11
#set terminal postscript solid eps color
#set output "packet_loss.eps"
#set title "Target"
#set autoscale
#set key box
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
#set xrange ["2009-08-06 16:00:00":"2009-08-08 07:00:00"]
#set yrange [0:20000]
set grid
set xlabel "Time (hour)"
set ylabel "UDP packets lost"
plot "test_udp_client.log.throughput.20" using 1:6 title "20MHz" with lines,\
     "test_udp_client.log.throughput.10" using 1:6 title "10MHz" with lines,\
     "test_udp_client.log.throughput.5" using 1:6 title "5MHz" with lines     
     