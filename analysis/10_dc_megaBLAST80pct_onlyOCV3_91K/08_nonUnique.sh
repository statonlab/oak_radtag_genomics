#!/bin/bash
# short script to check how many radtags align to each of the references
for f in `ls *.tsv`
do
	echo $f
	cut -f 1 $f | sort | uniq -dc | wc -l
done | paste - -
