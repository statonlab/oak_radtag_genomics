#!/bin/bash
# create total list
grep "^>" rads.gailing.fasta | sed 's/^>//g' > LIST
# short script to check how many radtags align to each of the references
for f in `ls *.tsv`
do
	cut -f 1 $f | sort | uniq > $f.loci
done
# combine OCV3_101 and 91.. I believe they go together
cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci | sort | uniq > OCV3.assembly.fasta.tsv.loci
# combine transcriptome hits
#cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci Quercus_rubra_120313_transcripts.assembly.assembly.fasta.tsv.loci | sort | uniq > transcriptome.loci
#cat OCV3_101K.up.assembly.fasta.tsv.loci OCV3_91K.up.assembly.fasta.tsv.loci | sort | uniq > transcriptome.loci
#cp OCV3_91K.up.assembly.fasta.tsv.loci transcriptome.loci
cp Quercus_rubra_120313_transcripts.assembly.assembly.fasta.tsv.loci transcriptome.loci
# combine genome hits
cat Ql_assembly.assembly.fasta.tsv.loci Qr_contigs.assembly.fasta.tsv.loci | sort | uniq > genome.loci
