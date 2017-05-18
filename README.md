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
