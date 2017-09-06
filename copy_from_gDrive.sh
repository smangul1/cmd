if [ $# -lt 3 ]
then
	echo "[1] - file extension"
	echo "[2] - id of the directory"
	echo "[3] name of QSUB"
	exit 1
fi


for f in *${1}; do echo "gdrive upload --parent $2 $f">run_${f}.sh>run_${f}.sh;done

ls run*sh | awk '{i+=1;print "qsub -cwd -V -N $3"i" -l h_data=8G,time=24:00:00 "$1}' > all.sh
chmod 755 all.sh
nohup ./all.sh &
