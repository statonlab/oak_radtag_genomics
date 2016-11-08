#!/bin/bash
# now check which are not in the transcriptome lists...
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
