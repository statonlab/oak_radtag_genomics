#!/bin/bash
# short script to check how many radtags align to each of the references
for f in `ls *.tsv`
do
	./05_blastQryLen.pl $f 49 | cut -f 1 | sort | uniq > $f.loci
done
# combine OCV3_101 and 91.. I believe they go together
cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci | sort | uniq > OCV3.assembly.fasta.tsv.loci
# combine transcriptome hits
cp OCV3_101K.up.assembly.fasta.tsv.loci transcriptome.loci
# combine genome hits
cat Ql_assembly.assembly.fasta.tsv.loci Qr_contigs.assembly.fasta.tsv.loci | sort | uniq > genome.loci
