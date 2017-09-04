import pandas
import sys
import csv
import os
import argparse


ap = argparse.ArgumentParser()
ap.add_argument('csv1', help='csv1')
ap.add_argument('csv2', help='csv2by sample')
ap.add_argument('merged', help='merged csv')
ap.add_argument('field', help='')
args = ap.parse_args()




csv1 = pandas.read_csv(args.csv1)
csv2 = pandas.read_csv(args.csv2)
merged = csv1.merge(csv2, on=args.field)




merged.to_csv(args.merged, index=False)


