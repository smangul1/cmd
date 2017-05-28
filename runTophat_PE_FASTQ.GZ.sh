#!/bin/bash




if [ $# -lt 4 ]
then
echo "********************************************************************"
echo "RNA-Seq data analyses on hoffman2 : tophat + cufflinks + isoem"
echo "For questions or suggestions contact:"
echo "Serghei Mangul (serghei@cs.ucla.edu)"
echo "********************************************************************"
echo ""

echo "rnaseq_hoffman2 <fastq_dir> <wdir> <bowtie2_index>"
echo ""
echo "1 <fastq_dir>  - dir with paired end fastq files, _1.fastq and _2.fastq"
echo "2 <wdir> - working directory, directory where results from rnaseq anlyses will be saved, for each samples separately directory will be created"
echo "3 <bowtie2_index - location of bowtie2 index, e.g. for human /u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome"
#echo "4 - <file with samples>"
echo "4 <options for tophat>, recomended option is \"-G /u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf \""


echo "--------------------------------------"
exit 1
fi


##Sample_12R0008_1.fastq



dir=$2
bowtie2_index=$3
mkdir $dir
cd $dir

echo "tophat options"
tophat_options=$4


#reads are named differntly this line needs to be manually corrected
#sed 's/R1/_1/' | sed 's/R2/_2/' | sed 's/merged//' | sed 's/\.\.//'
#example 089555A.merged.R1.fastq.gz


ls  ${1}/*fastq.gz >names.temp

while read line
do
    #newName=$(echo $line | sed 's/_R1/_1/' | sed 's/_R2/_2/' | sed 's/merged//' | sed 's/_001//' |  sed 's/_L001//' | sed 's/\.\.//')
    newName=$(echo $line | sed 's/.R1.fastq/_1.fastq/' | sed 's/.R2.fastq/_2.fastq/' | sed 's/merged//'  | sed 's/\.\.//')

    echo ${newName##*/}
    
    ln -s $line ${newName##*/} 
done<names.temp



#rm names.temp


ln -s ${2}/*fastq.gz ./





#ls *_1.fastq.gz | sed -e 's/_1/serghei1/' | sed -e 's/_1/serghei2/' | sed -e 's/_/moldova/' | sed -e 's/serghei1/_1/' | sed -e 's/serghei2/_2/' | awk -F '_' '{print $1}' | sed -e 's/moldova/_/g' > samples.txt

ls *_1.fastq.gz | awk -F "_1.fastq.gz" '{print $1}' > samples.txt



pwd



########1M reads
p=4000000
#p=400

echo "Advanced options for tophat ..."
echo $tophat_options





while read sdir
do

echo $sdir

f1=${dir}/${sdir}_1.fastq.gz
f2=${dir}/${sdir}_2.fastq.gz

rm -rf $sdir
mkdir $sdir
cd $sdir
echo "cd $sdir"
pwd





echo $f1
echo $f2

n=$(zcat $f1 | wc -l)
echo $n > nr.txt
m=$(echo $n| awk  '{ rounded = sprintf("%.0f", $1/'${p}'); print rounded }') #million
echo $m >m.txt
m1=$(echo $m | awk '{print $1-1}')
echo $m1



for((i=0;i<$((m-1));i++))
do

echo "Split reads"
echo $i


echo "cd ${dir}/${sdir}">>${sdir}_${i}.sh
echo "zcat ${f1} | awk '{if((k>=(0+$i)*$p) && (k<(1+$i)*$p)) print;k++ }' > ${dir}/${sdir}/${sdir}_1_${i}.fastq" >>${sdir}_${i}.sh
echo "zcat ${f2} | awk '{if((k>=(0+$i)*$p) && (k<(1+$i)*$p)) print;k++ }' > ${dir}/${sdir}/${sdir}_2_${i}.fastq" >>${sdir}_${i}.sh
#-p 8
echo ". /u/local/Modules/default/init/modules.sh" >>${sdir}_${i}.sh
echo "module load tophat/2.0.9" >>${sdir}_${i}.sh
echo "module load bowtie2/2.1.0" >>${sdir}_${i}.sh
echo "module load samtools"  >>${sdir}_${i}.sh
echo "tophat -v" >>${sdir}_${i}.sh
echo "bowtie -v" >>${sdir}_${i}.sh
echo "tophat -o tophat_out_${i} $tophat_options ${bowtie2_index} ${dir}/${sdir}/${sdir}_1_${i}.fastq ${dir}/${sdir}/${sdir}_2_${i}.fastq" >>${sdir}_${i}.sh
echo "mv ${dir}/${sdir}/tophat_out_${i}/accepted_hits.bam ${dir}/${sdir}/${i}_mapped.bam" >>${sdir}_${i}.sh
echo "mv ${dir}/${sdir}/tophat_out_${i}/unmapped.bam ${dir}/${sdir}/${i}_unmapped.bam" >>${sdir}_${i}.sh
echo "rm ${sdir}_1_${i}.fastq" >>${sdir}_${i}.sh
echo "rm ${sdir}_2_${i}.fastq" >>${sdir}_${i}.sh
echo "rm -rf tophat_out_${i}/logs" >>${sdir}_${i}.sh
echo "rm -rf tophat_out_${i}/tmp" >>${sdir}_${i}.sh
echo "echo \"$sdir $i DONE\">${dir}/${sdir}/${sdir}_${i}.done">>${sdir}_${i}.sh




done


echo "cd ${dir}/${sdir}">${sdir}_${m1}.sh
echo "zcat ${f1} | awk '{if(k>=($m-1)*$p) print;k++ }' > ${dir}/${sdir}/${sdir}_1_${m1}.fastq" >>${sdir}_${m1}.sh
echo "zcat ${f1} | awk '{if(k>=($m-1)*$p) print;k++ }' > ${dir}/${sdir}/${sdir}_2_${m1}.fastq"  >>${sdir}_${m1}.sh
#-p 8
echo ". /u/local/Modules/default/init/modules.sh"  >>${sdir}_${m1}.sh
echo "module load tophat/2.0.9"  >>${sdir}_${m1}.sh
echo "module load bowtie2/2.1.0" >>${sdir}_${m1}.sh
echo "module load samtools"  >>${sdir}_${m1}.sh
echo "tophat -v"  >>${sdir}_${m1}.sh
echo "bowtie -v"  >>${sdir}_${m1}.sh
echo "tophat  -o tophat_out_${m1}  $tophat_options  ${bowtie2_index} ${dir}/${sdir}/${sdir}_1_${m1}.fastq ${dir}/${sdir}/${sdir}_2_${m1}.fastq"  >>${sdir}_${m1}.sh
echo "mv ${dir}/${sdir}/tophat_out_${m1}/accepted_hits.bam ${dir}/${sdir}/${m1}_mapped.bam"  >>${sdir}_${m1}.shh
echo "mv ${dir}/${sdir}/tophat_out_${m1}/unmapped.bam ${dir}/${sdir}/${m1}_unmapped.bam"  >>${sdir}_${m1}.sh

echo "rm ${sdir}_1_${m1}.fastq" >>${sdir}_${m1}.sh
echo "rm ${sdir}_2_${m1}.fastq"  >>${sdir}_${m1}.sh
echo "rm -rf tophat_out_${m1}/logs"  >>${sdir}_${m1}.sh
echo "rm -rf tophat_out_${m1}/tmp"  >>${sdir}_${m1}.sh
echo "echo \"$sdir $m1 DONE\">${dir}/${sdir}/${sdir}_${m1}.done">>${sdir}_${m1}.sh






cd ..
pwd


done<samples.txt


cd $dir



ls */*sh | awk '{i+=1;print "if [ $1 == "i" ];then ./"$1" ;fi"}' > myFunc.sh
cp ~/project/code/myFuncFastWrapper.sh ./

chmod 755 *sh
chmod 755 */*sh

n=$(cat myFunc.sh | wc -l)
echo "qsub -cwd -V -N tophat -l h_data=8G,express,time=12:00:00 -t 1-${n}:1 myFuncFastWrapper.sh
"


qsub -cwd -V -N tophat -l h_data=8G,express,time=12:00:00 -t 1-${n}:1 myFuncFastWrapper.sh
