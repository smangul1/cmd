# Examples

```
python /u/home/s/serghei/code2/demultiplex/demultiplex_se.py /u/home/s/serghei/scratch/vazquez_rnaseq_new2/SxaQSEQsYA037L4/01_qseq/lane_4/s_4_*txt


while read line; do echo "cat ${line}.qseq* >${line}.qseq">run_${line}.sh; echo "/u/home/s/serghei/code2/demultiplex/qseq_to_fastq.sh ${line}.qseq ${line}" >>run_${line}.sh;done<../samples_TODO.txt

```

