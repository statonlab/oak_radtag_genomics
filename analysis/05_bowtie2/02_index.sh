#!/bin/bash
# create gsnap indicies
module load bowtie2
for f in `ls *.assembly.fasta`
do
	bowtie2-build \
	$f \
	$f &
done
