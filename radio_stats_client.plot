#set terminal x11
set terminal postscript eps solid color
set output "radio_stats_client.eps"
set grid
set title "Client"
set autoscale
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set xrange ["2009-08-06 16:00:00":"2009-08-08 07:00:00"]
set xlabel "Tiome (Hour)"
set ylabel "Strength (dBm)"
plot "radio_stats_client.log.tmp" using 1:3 title "Link Quality" with lines lt 4,\
     "radio_stats_client.log.tmp" using 1:4 title "Signal Level" with lines lt 6,\
     "radio_stats_client.log.tmp" using 1:5 title "Noise" with lines lt 7
