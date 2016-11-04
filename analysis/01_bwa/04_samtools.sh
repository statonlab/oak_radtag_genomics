#!/bin/bash
# sort and convert to bam
for f in `ls *.assembly.fasta`
do
echo "#$ -N sub$f
#$ -cwd
#$ -o ogs.out
#$ -e ogs.err	
/lustre/projects/staton/software/samtools-1.3/samtools view \
-@ 5 \
-m 2G \
-b $f.sam > $f.unsort.bam
/lustre/projects/staton/software/samtools-1.3/samtools sort \
-@ 5 \
-m 2G \
-o $f.bam $f.unsort.bam" > job.ogs
qsub job.ogs
rm -f job.ogs
done
