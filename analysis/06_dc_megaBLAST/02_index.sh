#!/bin/bash
# create blast indicies
module load blast
#for f in `ls *.fasta`
for f in OCV3_101K.fasta OCV3_91K.fasta Ql_assembly.fasta Qr_contigs.fasta
do
	makeblastdb \
	-dbtype nucl \
	-in $f \
	-title $f &
done
