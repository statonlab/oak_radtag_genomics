####link to fasta files and DB files
```
ln -s ../04_BLAST/*.nhr ./
ln -s ../04_BLAST/*.nin ./
ln -s ../04_BLAST/*.nsq ./
ln -s ../04_BLAST/*.assembly.fasta ./
ln -s ../04_BLAST/rads.gailing.fasta
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
	-perc_identity 80 \
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
#cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci Quercus_rubra_120313_transcripts.assembly.assembly.fasta.tsv.loci | sort | uniq > transcriptome.loci
#cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci | sort | uniq > transcriptome.loci
cp OCV3_91K.up.assembly.fasta.tsv.loci transcriptome.loci
```
####combine genome hits
```
cat Ql_assembly.assembly.fasta.tsv.loci Qr_contigs.assembly.fasta.tsv.loci | sort | uniq > genome.loci
```
---
####now check which are not in the transcriptome lists...
```
grep -Fwvf genome.loci transcriptome.loci > transcriptome_ONLY.loci
grep -Fwf transcriptome.loci genome.loci > transcriptome_inGenomic.loci
grep -Fwvf transcriptome.loci genome.loci > genome_ONLYtmp.loci
cat genome_ONLYtmp.loci transcriptome_ONLY.loci | sort | uniq > genome_ONLY.loci
rm -f genome_ONLYtmp.loci
for f in Ql_assembly Qr_contigs
do
grep -Fwvf $f.assembly.fasta.tsv.loci transcriptome.loci > transcriptome_ONLY_$f.loci
grep -Fwf transcriptome.loci $f.assembly.fasta.tsv.loci > transcriptome_inGenomic_$f.loci
grep -Fwvf transcriptome.loci $f.assembly.fasta.tsv.loci > genome_ONLYtmp_$f.loci
cat genome_ONLYtmp_$f.loci transcriptome_ONLY_$f.loci | sort | uniq > genome_ONLY_$f.loci
rm -f genome_ONLYtmp_$f.loci
done
wc -l *.loci
```
---
####run extractFasta for each of our loci lists...
```
for i in genome.loci genome_ONLY.loci transcriptome.loci transcriptome_ONLY.loci
do
      ./07_extractFasta.pl rads.gailing.fasta $i > $i.fasta
done
```
---
####short script to check how many radtags align to each of the references
```
for f in `ls *.tsv`
do
	echo $f
	cut -f 1 $f | sort | uniq -dc | wc -l
done | paste - -
```
---
