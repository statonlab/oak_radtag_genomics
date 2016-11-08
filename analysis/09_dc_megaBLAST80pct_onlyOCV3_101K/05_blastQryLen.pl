#!/usr/bin/perl
use strict;
# simple script to filter out hits below a certain match length BLAST

my $file = shift;
my $len  = shift;

open IN, $file || die "file not found-3 \n";

# read file line by line
while (my $i = <IN>)
{
    chomp($i);
    my @col = split /\t/, $i;
    # if line greater than length print it
    if ($col[3] > $len)
    {
        print "$i\n";
    }
}

close IN;
