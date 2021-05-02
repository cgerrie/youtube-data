# utube2.sh 
# Version 1.0 Jan 26 2021
# Charlie Gerrie

# Should be run in the folder containing/to contain the video files
# Uses new.txt for youtube-dl archive and outputs errors to errors.txt
list_file=new.txt
start_n=$1
error_file=errors.txt

trap 	ctrl_c INT

function ctrl_c() {
	echo "trapped ctrl-c"
	exit
}


n=0
n=$((n+$start_n))

while read p;
do
	echo "downloading $p"
	p=$(echo $p | xargs)
	printf -v number "%4d" $n
	echo $number
	youtube-dl \
	 "https://www.youtube.com/watch?v=$p" \
	 -o "$number-%(title)s-$p.%(ext)s" \
	 --playlist-start 3330 \
	 --playlist-end 3500 \
	 --download-archive files.txt \
	 --prefer-ffmpeg \
	 --max-filesize 1000M \
	 -i \
	 --cookies ~/cookies.txt    # cookies enabled
	ret=$?
	if [ $ret -ne 0 ]
	then
		echo -e "$p\t$number\t$ret" >> $error_file
	else
		n=$((n+1))
	fi

done < $list_file


read -p "remove $list_file? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	echo "deleting. (not actually deleting yet)"
	rm -f $1
else
	echo "not deleting"
fi


