#!/bin/bash
# create blast indicies
module load blast
for f in `ls *.assembly.fasta`
do
	makeblastdb \
	-dbtype nucl \
	-in $f \
	-title $f &
done
