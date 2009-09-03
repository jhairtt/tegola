set terminal x11
#set terminal postscript solid eps color
#set output "throughput_server.eps"
#set title "Target"
#set autoscale
#set key box
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
#set xrange ["2009-08-11 15:29:09":"2009-08-12 02:40:07"]
set grid
set xlabel "Time (hour)"
set ylabel "Throughput - Ornsay (Mbps)"
plot "test_udp_client.log.throughput.20" using 1:3 title "20MHz" with lines,\
     "test_udp_client.log.throughput.10" using 1:3 title "10MHz" with lines,\
     "test_udp_client.log.throughput.5" using 1:3 title "5MHz" with lines