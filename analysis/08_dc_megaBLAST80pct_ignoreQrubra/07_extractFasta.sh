#!/bin/bash
# run extractFasta for each of our loci lists...
for i in genome.loci genome_ONLY.loci transcriptome.loci transcriptome_ONLY.loci
do
      ./07_extractFasta.pl rads.gailing.fasta $i > $i.fasta
done
