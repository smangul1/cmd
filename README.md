
# install DESeq2 on hoffman2

Notice : http instead of http

```
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
```

# Subsample BAM file. In house script

```
python subsampleBam.py old.bam new.bam 0.5
```

# Transfer friles from/to Google Drive
```
gdrive download --recursive 0B6t4h9kX59LaTXVKeE9GSEl2WEk
```

# DE - to be moved to DE dir

## Rename files
```
for f in *; do new=$(echo $f | sed 's/mapped_//' | sed 's/-V//'); mv $f $new;done
```



# Connect cluster to github

- On the culster 

https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

- On the git hub page

https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/



# misc-scripts-hoffman2
Miscellaneous scripts for hoffman2

## Copy to GDrive vs cmd
Am example how to run `copy2gDrive.sh`

```
~/code2/misc-scripts-hoffman2/copy2gDrive.sh *sam 0Bx1fyWeQo3cOWk8ybjNkd1VPMTg sam
```

# sam to bam for multiple files via qsub

```
while read line; do echo ". /u/local/Modules/default/init/modules.sh">run_${line}.sh; echo "module load samtools">>run_${line}.sh; echo "samtools view -bS ${line}.sam | samtools sort - ${line}.bam">>run_${line}.sh;done<sample.xt 
```

# Run tophat2 hoffman2 : split by 1M and run 

- Example
```
run.sh :
/u/home/s/serghei/code/cmd/runTophat_PE_FASTQ.GZ.sh  /u/home/k/kwesel/scratch/new_fastq_PE/data/ $PWD/tophat/ /u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome "-G /u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf"


qsub -cwd -V -N prepare -l h_data=8G,time=5:00:00 run.sh 
```
