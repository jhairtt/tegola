#set terminal x11
set terminal postscript eps solid color
set output "radio_stats_server_ZOOM.eps"
set grid
set title "Server"
set autoscale
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set xrange ["2009-08-06 23:00:07":"2009-08-06 23:18:08"]
set xlabel "Time (Hour)"
set ylabel "Strength (dBm)"
plot "radio_stats_server.log.tmp" using 1:3 title "Link Quality" with lines lt 4,\
     "radio_stats_server.log.tmp" using 1:4 title "Signal Level" with lines lt 6,\
     "radio_stats_server.log.tmp" using 1:5 title "Noise" with lines lt 7
