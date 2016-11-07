#!/bin/bash
# short script to check how many radtags align to each of the references
module load samtools
for f in `ls *assembly.fasta`
do
	echo $f.bam
	samtools view -q 20 $f.bam | grep -v "^@" | wc -l
	samtools view -q 20 $f.bam | grep -v "^@" | cut -f 1 | sort | uniq > $f.LISTtmp
done | paste - -
