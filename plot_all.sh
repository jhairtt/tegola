#!/bin/sh

FILES=$(ls *.plot)

for i in $FILES; do
    sed 's/^set terminal x11/#set terminal x11/g;s/^#set terminal postscript/set terminal postscript/g;s/^#set output/set output/g;s/^set xrange/#set xrange/g' $i > $i.fixed.plot

    echo "Processing $i..."

    gnuplot $i.fixed.plot
done

EPSFILES=$(ls *.eps)
for i in $EPSFILES; do
    echo "Generating pdf for $i..."
    epstopdf $i
done

rm *.fixed.plot
