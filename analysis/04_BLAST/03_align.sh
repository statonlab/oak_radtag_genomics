#!/bin/bash
# run alignment
module load blast
for f in `ls *.assembly.fasta`
do
	blastn \
	-db $f \
	-query ./rads.gailing.fasta \
	-evalue 0.0001 \
	-outfmt 6 \
	-num_threads 5 \
	> $f.tsv &
done
