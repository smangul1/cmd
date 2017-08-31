import csv

file=open("/u/home/s/serghei/scratch/vazquez/control_steatosis_uncertain_vs_NASH_matrix.csv")
reader=csv.reader(file)
for row in reader:
	colnames=row
	break
file.close()

import pandas
#colnames = ['year', 'name', 'city', 'latitude', 'longitude']



data = pandas.read_csv('/u/home/s/serghei/scratch/vazquez/control_steatosis_uncertain_vs_NASH_matrix.csv', names=colnames)		
names = data.name.tolist()
GEA017 = data.GEA017.tolist()

print GEA017


