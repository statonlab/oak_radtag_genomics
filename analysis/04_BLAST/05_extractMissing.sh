#!/bin/bash
# create total list
grep "^>" rads.gailing.fasta | sed 's/^>//g' > LIST
# short script to check how many radtags align to each of the references
for f in `ls *.tsv`
do
	cut -f 1 $f | sort | uniq > $f.miss
done
