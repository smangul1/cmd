#! /usr/bin/env Rscript

 

# test if there is at least one argument: if not, return an error
if (length(args)<3) {
    stop("At least 3 argument must be supplied (input file).n", call.=FALSE)
}

args <- commandArgs(trailingOnly = TRUE)
print(args[1])


#print "directory with the counts files"
#print "conditions 1"
#print "condition 2"



library('DESeq2')
directory<-args[1]


sampleFiles <- scan(args[2], what="", sep="\n")





print(sampleFiles)
print("-------sampleFiles--------")

sampleCondition <- c(args[3],args[3], args[3], args[3], args[3], args[4], args[4],args[4],args[4], args[4])
sampleTable<-data.frame(sampleName=sampleFiles, fileName=sampleFiles, condition=sampleCondition)
print(sampleTable)

directory

ddsHTSeq<-DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory=directory, design=~condition)

colData(ddsHTSeq)$condition<-factor(colData(ddsHTSeq)$condition, levels=c(args[3],args[4]))
dds<-DESeq(ddsHTSeq)
res<-results(dds)
res<-res[order(res$padj),]
head(res)

print("-------res--------")


#file to save
outMA<-paste(args[1],args[3], args[4],".pdf",sep="")
print(outMA)

pdf(outMA)
plotMA(dds,ylim=c(-2,2),main="DESeq2")
dev.off()

#write DE genes to csv
outcsv<-paste(args[2],args[3], args[4],".csv",sep="")
resSig <- res[ which(res$padj < .1), ]
write.csv(resSig, file = outcsv)


#make PCA plot
rld <- rlogTransformation(dds, blind=TRUE)
outPCA<-paste(args[2],args[3], args[4],"PCA.pdf",sep="")
pdf(outPCA)
plotPCA(rld, intgroup=c("condition"))
dev.off()





