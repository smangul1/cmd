#!/bin/bash
#script to turn a qseq into one fastq file
SAMPLE=$1
OUTFILE=$2
cat $SAMPLE | awk 'BEGIN {OFS = ""}; {gsub(/\./,"N",$9)}; {gsub("@","A",$10)}; {print "@",$1,"_",$2,":",$3,":",$4,":",$5,":",$6,"#",$7,"/",$8}; {print $9}; {print "+",$1,"_",$2,":",$3,":",$4,":",$5,":",$6,"#",$7,"/",$8}; {print $10}' > ./${OUTFILE}.fastq
echo done with script

