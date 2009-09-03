#!/usr/bin/perl
# floating-average.pl
# Calculate the floating average over $1 values in all columns
# Reading from stdin, writing to stdout
# Example: floating-average.pl 3 <original >averaged

use strict;

my $span = $ARGV[0];
my @sums;
my @history;
my $count_sum = 1;
my $line_number = 0;
my $line;

while ($line = <STDIN>) {
  my @parts = split /\s+/, $line;

  my $c = 0;
  my $part;
  foreach $part(@parts) {
    if ($part =~ /^[+-]?\d+\.?\d*$/) { #is number
      if ($count_sum == $span) {
        $sums[$c] -= $history[$line_number % $span][$c];
      }
      $history[$line_number % $span][$c] = $part;
      $sums[$c] += $history[$line_number % $span][$c];
      if ($count_sum == $span) {
        print($sums[$c] / $span);
        print('  ');
      }
      ++$c;
    } else {
      if ($count_sum == $span) {
        print("$part  ");
      }
    }
  }

  if ($count_sum < $span) {
    ++$count_sum;
  } else {
    print("\n");
  }
  ++$line_number;
}
