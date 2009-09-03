#set terminal x11
set terminal postscript eps solid color
set output "radio_stats_client_link_per_width.eps"
set grid
set title "Link Quality"
set autoscale
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set xrange ["2009-08-07 04:00:00":"2009-08-07 20:00:00"]
set xlabel "Time (Hour)"
set ylabel "Strength (dBm)"
plot "radio_stats_client.log.tmp.20" using 1:3 title "20MHz" with lines,\
     "radio_stats_client.log.tmp.10" using 1:3 title "10MHz" with lines,\
     "radio_stats_client.log.tmp.5" using 1:3 title "5MHz" with lines
