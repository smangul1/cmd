#!/bin/bash


if [ $# -lt 1 ]
then
#echo "[1] - file with samples located in the "
echo "[1] dir with the analysis"
exit 1
fi

dir=$1

cd $dir

pwd


while read sample
do

cd ${dir}/${sample}
pwd
n=$(ls  *_mapped.bam | wc -l)
#echo $n
m=$(cat m.txt) 

echo "Number of bams $n/$m"

if [ $m == $n ]
then
echo "$sample DONE!"
pwd



echo "cd ${dir}/${sample}" >merge_${sample}.sh
echo "mkdir mapped"  >>merge_${sample}.sh
echo "mkdir unmapped" >>merge_${sample}.sh
echo ". /u/local/Modules/default/init/modules.sh" >>merge_${sample}.sh
echo "module load samtools" >>merge_${sample}.sh
echo "module load bamtools" >>merge_${sample}.sh
echo "samtools merge ./mapped/mapped_${sample}.bam *_mapped.bam" >>merge_${sample}.sh
echo "samtools merge ./unmapped/unmapped_${sample}.bam *_unmapped.bam" >>merge_${sample}.sh
echo "samtools index ./mapped/mapped_${sample}.bam" >>merge_${sample}.sh
echo "samtools index ./unmapped/unmapped_${sample}.bam" >>merge_${sample}.sh
#echo "bamtools convert -in ./unmapped/unmapped_${sample}.bam -format fastq > ./unmapped/unmapped_${sample}.fastq" >>merge_${sample}.sh
#echo "rm *bam" >>merge_${sample}.sh
#echo "qsub -cwd -V -N merge_${sample} -l h_data=16G,time=24:00:00 ${dir}/merge_${sample}.sh">>${dir}/jobs2.txt
#echo "qsub -cwd -V -N merge_${sample} -l h_data=4G,time=00:30:00 ${dir}/merge_${sample}.sh">>${dir}/jobs2.txt

fi

done<${dir}/samples.txt

cd $dir
pwd

ls */merge*sh | awk '{i+=1;print "qsub -cwd -V -N merge"i" -l h_data=4G,time=04:00:00 "$1}' > allMerge.sh
chmod 755 allMerge.sh

echo "Please run nohup ./allMerge.sh &"

