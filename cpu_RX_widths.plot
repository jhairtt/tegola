#set terminal x11
set terminal postscript solid eps color
set output "cpu_RX_widths.eps"
#set title "Target"
#set autoscale
set key box
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set xrange ["2009-08-06 16:00:00":"2009-08-08 07:00:00"]
#set xrange ["2009-08-06 16:00:00":"2009-08-08 07:00:00"]
#set yrange [0:20000]
set grid
set xlabel "Time (hour)"
set ylabel "%CPU RX"
plot "test_udp_client.log.throughput.20" using 1:5 title "20MHz" with lines,\
     "test_udp_client.log.throughput.10" using 1:5 title "10MHz" with lines,\
     "test_udp_client.log.throughput.5" using 1:5 title "5MHz" with lines     
     