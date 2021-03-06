set terminal x11
#set terminal postscript eps solid color
#set output "radio_stats_server_level_per_width.eps"
set grid
set title "Signal Level"
set autoscale
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set ytics -70,5
set ytics add ("-83\n(36Mbps)" -83, "-86\n(24Mbps)" -86, "-77\n(48Mbps)" -77, "-74\n(54Mbps)" -74, "-90\n(18Mbps)" -90)  
#set xrange ["2009-08-07 04:00:00":"2009-08-07 20:00:00"]
set xlabel "Time (Hour)"
set ylabel "Strength (dBm)"
plot "radio_stats_server.log.tmp.20" using 1:4 title "20MHz" with lines,\
     "radio_stats_server.log.tmp.10" using 1:4 title "10MHz" with lines,\
     "radio_stats_server.log.tmp.5" using 1:4 title "5MHz" with lines
