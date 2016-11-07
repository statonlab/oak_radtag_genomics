#!/bin/bash
# index with samtools
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/samtools-1.3/samtools index \
	$f.bam &
done
