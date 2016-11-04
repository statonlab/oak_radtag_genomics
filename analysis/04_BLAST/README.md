####link to fasta files
```
ln -s ../../archive/*.fasta ./
```
---
####create blast indicies
```
module load blast
for f in `ls *.assembly.fasta`
do
	makeblastdb \
	-dbtype nucl \
	-in $f \
	-title $f &
done
```
---
####run alignment
```
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
```
---
####short script to check how many radtags align to each of the references
```
for f in `ls *.tsv`
do
	echo $f
	echo "total"
	cut -f 1 $f | wc -l
	cut -f 1 $f | sort | uniq | wc -l
done
```
---
