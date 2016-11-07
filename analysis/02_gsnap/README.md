%10
####link to fasta files
```
ln -s ../../archive/*.fasta ./
```
---
####create gsnap indicies
```
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/gmap-2016-09-14/bin/gmap_build \
	--dir=/lustre/projects/staton/projects/oak_radtag_genomics/analysis/02_gsnap/ \
	--db=$f.genome \
	$f &
done
```
---
####run gsnap
```
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
