import argparse
import csv

ap=argparse.ArgumentParser()
ap.add_argument('table',help='table with gene names and ids')
args=ap.parse_args()

dict_genes={}
#get gene names
k=0
file=open("/u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf")
reader=csv.reader(file,delimiter="\t")
for row in reader:
    id=row[8].split("gene_id")[1].split(";")[0].replace("\"","").replace(" ","")
    name=row[8].split("gene_name")[1].split(";")[0].replace("\"","").replace(" ","")
    dict_genes[id]=name
    #geneIDs.append(id)
    k+=1
file.close()


print "Proccessed ", k, "line from /u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf"

file=open(args.table,"w") 
for key, value in dict_genes.iteritems():
	file.write(key+","+value)
	file.write("\n")


file.close()	




