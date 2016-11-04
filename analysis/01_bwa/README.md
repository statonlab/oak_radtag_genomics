Map radtags to oak genomes and transcriptomes.
####link to fasta files
```
ln -s ../../archive/*.fasta ./
```
---
####create bwa index
```
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/bwa-0.7.15/bwa index \
	-p $f \
	$f &
done
```
---
####run alignment
```
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/bwa-0.7.15/bwa mem \
	-t 5 \
	$f \
	./rads.gailing.fasta \
	> $f.sam &
done
```
---
####sort and convert to bam
```
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
```
---
####index with samtools
```
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/samtools-1.3/samtools index \
	$f.bam &
done
```
---
####short script to check how many radtags align to each of the references
```
module load samtools
for f in `ls *assembly.fasta`
do
	echo $f.bam
	echo "total"
	samtools view -q 20 $f.bam | grep -v "^@" | wc -l
	samtools view -q 20 $f.bam | grep -v "^@" | cut -f 1 | sort | uniq > $f.LISTtmp
done
```
---
