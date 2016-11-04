#!/bin/bash
# run gsnap
for f in `ls *.assembly.fasta`
do
#echo "#$ -N a$f
#$ -cwd
#$ -e ogs.err
#$ -o ogs.out
/lustre/projects/staton/software/gmap-2016-09-14/bin/gsnap \
--dir=/lustre/projects/staton/projects/oak_radtag_genomics/analysis/02_gsnap/ \
--db=$f.genome \
--max-mismatches=0.1 \
-output-file=$f.sam \
-t 30 \
-A sam \
./rads.gailing.fasta > $f.gsnap.out.txt
#" > job.ogs
#qsub job.ogs
#rm -f job.ogs
done
