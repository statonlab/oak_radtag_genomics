#!/bin/bash
# create gsnap indicies
for f in `ls *.assembly.fasta`
do
	/lustre/projects/staton/software/gmap-2016-09-14/bin/gmap_build \
	--dir=/lustre/projects/staton/projects/oak_radtag_genomics/analysis/02_gsnap/ \
	--db=$f.genome \
	$f &
done
