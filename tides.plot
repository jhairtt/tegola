#set terminal x11
set terminal postscript eps solid color
set output "tides.eps"
set grid
#set title "Signal Level"
set autoscale
set datafile separator "|"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set yrange [0:5]
#set ytics 0, 1
#set ytics nomirror
#set xrange ["2009-08-07 04:00:00":"2009-08-07 20:00:00"]
set xlabel "Time (Hour)"
set ylabel "Tide Level - Corran (m)"

plot "tides.dat" using 1:2 title "Tide Level(m)" w filledcurves x1 axis x1y1 5
