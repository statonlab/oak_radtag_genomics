ln -s ../../archive/*.fasta ./
```
---
####create gsnap indicies
```
module load bowtie2
for f in `ls *.assembly.fasta`
do
	bowtie2-build \
	$f \
	$f &
done
```
---
####run bt2
```
module load bowtie2
for f in `ls *.assembly.fasta`
do
bowtie2 \
-p 30 \
-x $f \
-f rads.gailing.fasta > $f.bt2.out.txt
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
	samtools view -q 20 $f.bam | grep -v "^@" | wc -l
	samtools view -q 20 $f.bam | grep -v "^@" | cut -f 1 | sort | uniq > $f.LISTtmp
done | paste - -
```
---
####short script to check how many radtags align to each of the references
```
for l in `ls *LISTtmp`
do
	for i in `ls *LISTtmp`
	do
		echo $l, $i
		# unique
		echo "unique"
		cat $i $l | sort | uniq | wc -l
		# shared
		echo "shared"
		cat $i $l | sort | uniq -d | wc -l
	done
done
```
---
