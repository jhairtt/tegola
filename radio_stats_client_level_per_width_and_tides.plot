set terminal x11
#set terminal postscript eps solid color
#set output "radio_stats_client_level_per_width_and_tides.eps"
set grid
#set title "Signal Level"
set autoscale
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
#set y2range [0:30]
#set y2tics 0, 2
set ytics nomirror
set ytics -70,5
set ytics add ("-83\n(36Mbps)" -83, "-86\n(24Mbps)" -86, "-77\n(48Mbps)" -77, "-74\n(54Mbps)" -74, "-90\n(18Mbps)" -90)  
#set xrange ["2009-08-07 04:00:00":"2009-08-07 20:00:00"]
set xlabel "Time (Hour)"
set ylabel "Signal Strength - Corran (dBm)"
#set y2label "Tide Level (m)"

plot "radio_stats_client.log.tmp.20" using 1:4 title "20MHz" with lines axis x1y1 ,\
     "radio_stats_client.log.tmp.10" using 1:4 title "10MHz" with lines axis x1y1,\
     "radio_stats_client.log.tmp.5" using 1:4 title "5MHz" with lines axis x1y1
#     ,\
#     "tides.dat" using 1:2 title "Tide Level" w filledcurves x1 axis x1y2 
#     "tides.dat" using 1:2 title "Tide Level" w boxes fs solid 3 axis x1y2 
