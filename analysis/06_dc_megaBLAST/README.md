####link to fasta files
```
ln -s ../../archive/*.fasta ./
```
---
####create blast indicies
```
module load blast
#for f in `ls *.fasta`
for f in OCV3_101K.fasta OCV3_91K.fasta Ql_assembly.fasta Qr_contigs.fasta
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
	-task dc-megablast \
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
	cut -f 1 $f | wc -l
	cut -f 1 $f | sort | uniq | wc -l
done | paste - - -
```
---
####create total list
```
grep "^>" rads.gailing.fasta | sed 's/^>//g' > LIST
```
####short script to check how many radtags align to each of the references
```
for f in `ls *.tsv`
do
	cut -f 1 $f | sort | uniq > $f.loci
done
```
####combine OCV3_101 and 91.. I believe they go together
```
cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci | sort | uniq > OCV3.assembly.fasta.tsv.loci
```
####combine transcriptome hits
```
cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci Quercus_rubra_120313_transcripts.assembly.assembly.fasta.tsv.loci | sort | uniq > transcriptome.loci
```
####combine genome hits
```
cat Ql_assembly.assembly.fasta.tsv.loci Qr_contigs.assembly.fasta.tsv.loci | sort | uniq > genome.loci
```
####now check which are not in the transcriptome lists...
```
grep -Fwvf transcriptome.loci genome.loci | wc -l
grep -Fwf transcriptome.loci genome.loci | wc -l
wc -l transcriptome.loci
wc -l genome.loci
```
---
