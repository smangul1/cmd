import os
import argparse
import csv
import sys

ap=argparse.ArgumentParser()
ap.add_argument('metaData',help='file with metadata in CSV format')
ap.add_argument('dir',help='dir with counts')
ap.add_argument('out', help='file with metadata suitable for Deseq2')
ap.add_argument('tissue', help='V or H')

args=ap.parse_args()

file=open(args.metaData)
reader=csv.reader(file)
next(reader,None)

setM=set()
for row in reader:
	setM.add(row[6])

print setM

file.close()

file=open(args.metaData)
reader=csv.reader(file)
next(reader,None)



filename1=args.out+"_control_steatosis_uncertain_vs_NASH.csv"
filename2=args.out+"_control_steatosis_vs_NASH.csv"
filename3=args.out+"_control_steatosis_vs_NASH.csv"
filename4=args.out+"_control_vs_NASH.csv"
filename5=args.out+"_steatosis_unceratin_vs_NASH.csv"



fileOut1=open(filename1,"w")
fileOut2=open(filename2,"w")
fileOut3=open(filename3,"w")
fileOut4=open(filename4,"w")
fileOut5=open(filename5,"w")




fileOut1.write("sampleName,fileName,condition")
fileOut1.write("\n")
fileOut2.write("sampleName,fileName,condition")
fileOut2.write("\n")
fileOut3.write("sampleName,fileName,condition")
fileOut3.write("\n")
fileOut4.write("sampleName,fileName,condition")
fileOut4.write("\n")
fileOut5.write("sampleName,fileName,condition")
fileOut5.write("\n")

#pheno1 : control+steatosis+uncertain vs NASH
#pheno2 : control+steatosis vs NASH
#pheno3 : control vs steatosis
#pheno4 : control vs NASH
#pheno5 : steatosis+unceratin vs NASH


for row in reader:
    pheno1=""
    pheno2=""
    pheno3=""
    pheno4=""
    pheno5=""
    
    sample=row[0]
    filename=args.dir+"/mapped_"+sample+"-"+args.tissue+".counts"
    pheno=row[6]
    
    if pheno=="NASH":
        pheno1="NASH"
        pheno2="NASH"
        pheno3="NASH"
        pheno4="NASH"
        pheno5="NASH"
    elif pheno=="Control":
        pheno1="control+steatosis+uncertain"
        pheno2="control+steatosis"
        pheno3="control"
    elif pheno=="Steatosis":
        pheno1="control+steatosis+uncertain"
        pheno2="control+steatosis"
        pheno5="steatosis+unceratin"
    elif pheno=="uncertain":
        pheno1="control+steatosis+uncertain"
        pheno5="steatosis+unceratin"
    else:
        print pheno
        print "Error with phenotype"
        sys.exit(1)

    sample2 = sample + "-"+args.tissue
    print sample2
    if os.path.isfile(filename) and pheno1!="":
        fileOut1.write(sample2+","+filename+","+pheno1)
        fileOut1.write("\n")

    if os.path.isfile(filename) and pheno2!="":
        fileOut2.write(sample2+","+filename+","+pheno2)
        fileOut2.write("\n")

    if os.path.isfile(filename) and pheno3!="":
        fileOut3.write(sample2+","+filename+","+pheno3)
        fileOut3.write("\n")

    if os.path.isfile(filename) and pheno4!="":
        fileOut4.write(sample2+","+filename+","+pheno4)
        fileOut4.write("\n")

    if os.path.isfile(filename) and pheno5!="":
        fileOut5.write(sample2+","+filename+","+pheno5)
        fileOut5.write("\n")

print "Save to ", filename1,filename2,filename3,filename4,filename5
print "Done prepare_Metadata_for_DE.py!",


#sampleName,fileName,condition
#mapped_GEA017-H.counts,mapped_GEA017-H.counts,not-treated
