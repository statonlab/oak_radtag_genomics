#!/bin/bash
# create bwa index
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/bwa-0.7.15/bwa index \
	-p $f \
	$f &
done
