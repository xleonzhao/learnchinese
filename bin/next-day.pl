#!/usr/bin/env perl

use strict;
my $debug = 0;

sub Usage {
  print("Usage: $0 next-day.pl <date>\n");
  print(" e.g.: $9 2017-09-03\n");
  exit;
}

sub next_day {
  my $date = shift;

  my ($mon, $day, $year);

  ($year, $mon, $day)=split('-', $date);
  if ($mon > 12 || $day > 31) {
    Usage;
  }

  my $maxday = 30;

  if ($mon==1 || $mon==3 || $mon==5 || $mon==7 || $mon==8 || $mon==10 || $mon==12) {
    $maxday = 31;
  }
  if ($mon==2) {
    if ($year % 4 == 0) {
      $maxday = 29;
    } else {
      $maxday = 28;
    }
  }

  $day++;
  if ($day > $maxday) {
    $day = 1;
    $mon++;
    if ($mon > 12) {
      $mon = 1;
      $year++;
    }
  }
  return sprintf("%4d-%02d-%02d", $year, $mon, $day); 
}

my $input = $ARGV[0];

if (! defined $input || $input !~ /-/) {
  Usage();
}

my $nd = next_day($input);
print("$nd\n");

