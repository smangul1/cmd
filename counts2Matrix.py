import argparse
import csv
import sys
import glob
import os

def file2list(file,cList):
    file=open(file)
    reader=csv.reader(file,delimiter="\t")
    for row in reader:
        if "__" not in row[0]:
            cList.append(int(row[1]))

    file.close()


ap=argparse.ArgumentParser()
ap.add_argument('dir', help='dir with count files')
ap.add_argument('nr',help='file with number of original reads')
ap.add_argument('gtf',help='file with number of original reads')
ap.add_argument('metadata',help='file with metadata')
ap.add_argument('batch',help='file with metadata')
ap.add_argument('out',help='file to save matrix')
args=ap.parse_args()

files=glob.glob(args.dir+"/*counts")



#batch GEA21-H,1
dict_batch={}
file=open(args.batch)
reader=csv.reader(file)
for row in reader:
    sample=row[0]
    b=row[1]
    dict_batch[sample]=b





#metadata
#ID,Steatosis,Ballooning,Inflammation,NAS,HGNA,Status,Age,Sex,BMI,Glucose,Totalcholesterol,Triglycerides,HDL,AST(liverenzime),ALT(liverenzime)
#GEA017,0,0,0,0,0,Control,47,Male,30.76,127,144,54,45,24,18

samplesSetMetadata=set()

dict_tissue={}
dict_Steatosis={}
dict_Ballooning={}
dict_Inflammation={}
dict_NAS={}
dict_HGNA={}
dict_Status={}
dict_Age={}
dict_Sex={}
dict_BMI={}
dict_Glucose={}
dict_Totalcholesterol={}
dict_Triglycerides={}
dict_HDL={}
dict_AST={}
dict_ALT={}

file=open(args.metadata)
reader=csv.reader(file)
for row in reader:
    sample=row[0]
    samplesSetMetadata.add(sample)
    Steatosis=row[1]
    Ballooning=row[2]
    Inflammation=row[3]
    NAS=row[4]
    HGNA=row[5]
    Status=row[6]
    Age=row[7]
    Sex=row[8]
    BMI=row[9]
    Glucose=row[10]
    Totalcholesterol=row[11]
    Triglycerides=row[12]
    HDL=row[13]
    AST=row[14]
    ALT=row[15]
    
    
    dict_Steatosis[sample]=Steatosis
    dict_Ballooning[sample]=Ballooning
    dict_Inflammation[sample]=Inflammation
    dict_NAS[sample]=NAS
    dict_HGNA[sample]=HGNA
    dict_Status[sample]=Status
    dict_Age[sample]=Age
    dict_Sex[sample]=Sex
    dict_BMI[sample]=BMI
    dict_Glucose[sample]=Glucose
    dict_Totalcholesterol[sample]=Totalcholesterol
    dict_Triglycerides[sample]=Triglycerides
    dict_HDL[sample]=HDL
    dict_AST[sample]=AST
    dict_ALT[sample]=ALT


dict_genes={}

#get gene id list
geneIDs=[]
geneNames=[]

file=open(files[0])
reader=csv.reader(file,delimiter="\t")
for row in reader:
    if "__" not in row[0]:
        geneIDs.append(row[0])
file.close()


#get gene names
k=0
file=open(args.gtf)
reader=csv.reader(file,delimiter="\t")
for row in reader:
    id=row[8].split("gene_id")[1].split(";")[0].replace("\"","").replace(" ","")
    name=row[8].split("gene_name")[1].split(";")[0].replace("\"","").replace(" ","")
    dict_genes[id]=name
    k+=1
file.close()

for i in geneIDs:
    geneNames.append(dict_genes[i])




file=open(args.nr)
reader=csv.reader(file)


dict_nr={}

next(reader,None)

for row in reader:
    sample=row[0]
    n=float(row[1])
    dict_nr[sample]=n


#rows are genes and columns are samples.




dict_raw={}
dict_RPM={}





for f in files:
    cList=[]
    cList[:]=[]
    base=os.path.basename(f)
    sample=os.path.splitext(base)[0]
    file2list(f,cList)
    base=os.path.basename(f)
    sample=os.path.splitext(base)[0].replace('mapped_','')
    dict_raw[sample]=cList
    newList = [x / dict_nr[sample] for x in cList]
    dict_RPM[sample]=newList



dict_raw["A_GeneID"]=geneIDs
dict_raw["A_GeneNames"]=geneNames


#save to out file,rows are genes and columns are samples.
import pandas as pd
df_raw = pd.DataFrame(dict_raw)
df_raw.to_csv(args.out+".raw", sep=',')


df_RPM = pd.DataFrame(dict_raw)
df_RPM.to_csv(args.out+".RPM", sep=',')

# After file is saved open again







for f in files:
    
    sample=os.path.splitext(base)[0].replace('mapped_','')
    if "-V" in sample:
        sample2=sample.split("-V")[0]
        dict_tissue[sample2]="Adipose"
    elif "-H" in sample:
        sample2=sample.split("-H")[0]
        dict_tissue[sample2]="Liver"


file=open(args.out+".raw")
reader=csv.reader(file)


list_batch=[]
list_tissue=[]
list_tissue=[]
list_Steatosis=[]
list_Ballooning=[]
list_Inflammation=[]
list_NAS=[]
list_HGNA=[]
list_Status=[]
list_Age=[]
list_Sex=[]
list_BMI=[]
list_Glucose=[]
list_Totalcholesterol=[]
list_Triglycerides=[]
list_HDL=[]
list_AST=[]
list_ALT=[]


for row in reader:
    print row
    for i in row:
        if "Gene" not in i and i!="":
            sample=i
            
            
            if "-V" in sample:
                sample2=sample.split("-V")[0]
                list_tissue.append("Adipose")
            elif "-H" in sample:
                sample2=sample.split("-H")[0]
                list_tissue.append("Liver")
            
            
            list_batch.append(dict_batch[sample])

            if sample2 in samplesSetMetadata:
                list_Steatosis.append(dict_Steatosis[sample2])
                list_Ballooning.append(dict_Ballooning[sample2])
                list_Inflammation.append(dict_Inflammation[sample2])
                list_NAS.append(dict_NAS[sample2])
                list_HGNA.append(dict_HGNA[sample2])
                list_Status.append(dict_Status[sample2])
                list_Age.append(dict_Age[sample2])
                list_Sex.append(dict_Sex[sample2])
                list_BMI.append(dict_BMI[sample2])
                list_Glucose.append(dict_Glucose[sample2])
                list_Totalcholesterol.append(dict_Totalcholesterol[sample2])
                list_Triglycerides.append(dict_Triglycerides[sample2])
                list_HDL.append(dict_HDL[sample2])
                list_AST.append(dict_AST[sample2])
                list_ALT.append(dict_ALT[sample2])
            
            else:
                print "WARNING ",sample2


    break


file=open(args.out+".header","w")

batch=",A_GeneID,A_GeneNames," + ','.join(list_batch)
tissue=",A_GeneID,A_GeneNames," + ','.join(list_tissue)
Ballooning=",A_GeneID,A_GeneNames," + ','.join(list_Ballooning)
Inflammation=",A_GeneID,A_GeneNames," + ','.join(list_Inflammation)
NAS=",A_GeneID,A_GeneNames," + ','.join(list_NAS)
HGNA=",A_GeneID,A_GeneNames," + ','.join(list_HGNA)
Status=",A_GeneID,A_GeneNames," + ','.join(list_Status)
Age=",A_GeneID,A_GeneNames," + ','.join(list_Age)
Sex=",A_GeneID,A_GeneNames," + ','.join(list_Sex)
BMI=",A_GeneID,A_GeneNames," + ','.join(list_BMI)
Glucose=",A_GeneID,A_GeneNames," + ','.join(list_Glucose)
Totalcholesterol=",A_GeneID,A_GeneNames," + ','.join(list_Totalcholesterol)
Triglycerides=",A_GeneID,A_GeneNames," + ','.join(list_Triglycerides)
HDL=",A_GeneID,A_GeneNames," + ','.join(list_HDL)
AST=",A_GeneID,A_GeneNames," + ','.join(list_AST)
ALT=",A_GeneID,A_GeneNames," + ','.join(list_AST)




file.write(tissue)
file.write("\n")
file.write(batch)
file.write("\n")
file.write(Status)
file.write("\n")
file.write(Ballooning)
file.write("\n")
file.write(Inflammation)
file.write("\n")
file.write(NAS)
file.write("\n")
file.write(HGNA)
file.write("\n")
file.write(Age)
file.write("\n")
file.write(Sex)
file.write("\n")
file.write(BMI)
file.write("\n")
file.write(Glucose)
file.write("\n")
file.write(Totalcholesterol)
file.write("\n")
file.write(Triglycerides)
file.write("\n")
file.write(HDL)
file.write("\n")
file.write(AST)
file.write("\n")
file.write(ALT)
file.write("\n")
