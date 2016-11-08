#!/bin/bash
# short script to check how many radtags align to each of the references
for f in `ls *.tsv`
do
	echo $f
	cut -f 1 $f | sort | uniq -c | sed 's/^ *//g' | sed 's/ /\t/g' | awk '{print $2,$1}' | sed 's/locus\.//g' | sort -h -r | sed 's/^/locus\./g' \
        | cut -d ' ' -f 2 | sort | uniq -c | sed 's/^ *//g' | sed 's/ /\t/g' | awk '{print $2,$1}' | sort -h -r | sed 's/ /,/g' > $f.hist
done
