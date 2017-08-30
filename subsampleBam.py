import csv
import sys
import argparse
from collections import Counter
import numpy


ap = argparse.ArgumentParser()
ap.add_argument('inBam', help='inBam')
ap.add_argument('outBam', help='outBam')

ap.add_argument('fraction', help='fraction')

args = ap.parse_args()


import pysam
import random

bam = pysam.AlignmentFile(args.inBam) # Change me
output = pysam.AlignmentFile(args.outBam, "wb", template=bam) # Change me
subsample_chrom = "chr21" # Change me if needed
fraction = float(args.fraction) # Change me

for read in bam.fetch():
    if random.random() < fraction:
        output.write(read)
bam.close()
output.close()




