#!/bin/bash
# run alignment
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/bwa-0.7.15/bwa mem \
	-t 5 \
	$f \
	./rads.gailing.fasta \
	> $f.sam &
done
