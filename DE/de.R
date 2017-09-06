#! /usr/bin/env Rscript

 

# test if there is at least one argument: if not, return an error
if (length(args)<1) {
    print ("1: file with metadata")
    print ("2: out dir, to be created")
    print ("3 : out file")
    stop("At least 2 argument must be supplied : input file", call.=FALSE)
}

args <- commandArgs(trailingOnly = TRUE)



#print "directory with the counts files"
#print "conditions 1"
#print "condition 2"



dir.create(args[2])
comparision=args[3]


library('DESeq2')


print (args[1])
sampleTable=read.csv(args[1])
ddsHTSeq<-DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory="", design=~condition)



dds<-DESeq(ddsHTSeq)


#normalize using DESeq
outcsv_norm_deseq<-paste(args[2],args[3],"_geneCounts_norm_deseq.csv",sep="")
countsN=counts(dds, normalized=TRUE)
write.csv(countsN, file =outcsv_norm_deseq)


#DE
res<-results(dds)
res<-res[order(res$padj),]
head(res)

print("-------res--------")


#norm per condition
outcsv1<-paste(args[2],args[3],"_geneCounts_perCondition.csv",sep="")

baseMeanPerLvl <- sapply( levels(dds$condition), function(lvl) rowMeans( counts(dds,normalized=TRUE)[,dds$condition == lvl] ) )
write.csv(baseMeanPerLvl, file =outcsv1)








#file to save
outMA<-paste(args[2],args[3],".pdf",sep="")
print(outMA)

pdf(outMA)
plotMA(dds,ylim=c(-2,2),main=comparision)
dev.off()

print ("write DE genes to csv")
outcsv<-paste(args[2],args[3],".csv",sep="")
resSig <- res[ which(res$padj < .1), ]
write.csv(resSig, file = outcsv)


#---------------------------------------
print ("Normalize using rld")
outcsvN<-paste(args[2],args[3],"_norm_rld.csv",sep="")
rld <- rlog(dds)
write.csv(assay(rld), file = outcsvN)


#---------------------------------------
print ("make PCA plot")
outPCA<-paste(args[2],"/PCA_",comparision,".pdf",sep="")
pdf(outPCA)
plotPCA(rld, intgroup=c("condition"))
dev.off()


print ("save PCA plot into a file")
outPCA_csv<-paste(args[2],"/PCA_txt_",comparision,".csv",sep="")
library(ggplot2)
dataPCA=(plotPCA(rld, intgroup=c("condition"), returnData=TRUE))
write.csv(dataPCA, file = outPCA_csv)


print ("DONE! de.R")



