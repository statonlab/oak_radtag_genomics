#!/bin/bash
# short script to check how many radtags align to each of the references
for l in `ls *LISTtmp`
do
	for i in `ls *LISTtmp`
	do
		echo $l, $i
		# unique
		echo "unique"
		cat $i $l | sort | uniq | wc -l
		# shared
		echo "shared"
		cat $i $l | sort | uniq -d | wc -l
	done
done
