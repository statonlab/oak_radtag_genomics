#!/bin/bash
# run bt2
module load bowtie2
for f in `ls *.assembly.fasta`
do
bowtie2 \
-p 30 \
-x $f \
-f rads.gailing.fasta > $f.bt2.out.txt
done
