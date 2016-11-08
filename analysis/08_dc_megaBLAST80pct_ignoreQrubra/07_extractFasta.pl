#!/usr/bin/perl
use strict;
# simple script to extract a list of entries from a fasta file
# does not catch errors when entry from list is missing from the fasta file
# it attempts to extract from... (for this context that error would be unexpected).

# fasta file
my $file = shift;
# list file
my $file2 = shift;
open IN, $file || die "File not found -3 \n";

my %fasta;
my $header;
# load fasta file into hash
while(my $i = <IN>)
{
    chomp($i);
    if($i =~ /^>(.*)/)
    {
        $header = $1;
    }
    else
    {
        #print ">$header\n";
        #print "$i\n"; 
        $fasta{"$header"}=$i;
    }
}

close IN;

# cycle through list file and print matching entry from hash in fasta format
open IN, $file2 || die "File not found -3 \n";
while (my $i = <IN>)
{
    chomp($i);
    print ">$i\n";
    print $fasta{$i} . "\n";
}
