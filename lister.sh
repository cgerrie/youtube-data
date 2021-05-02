# lister.sh
# Version 1.0 April 15 2021
# Charlie Gerrie

# This script makes a file with a list of video IDs along with their download number, from a folder downloaded by utube2.sh

# pipe in ls of ytwl
ytwl=/media/sf_data/youtubeWL
ls $ytwl | grep -oE '[0-9]{4}.*-[a-zA-Z0-9_-]{11}\..*' - > list.txt

#grep -oE '\-[a-zA-Z0-9_-]{11}\.' - < list.txt > gennedList.txt
perl -lne 'my $n = substr $_, 0, 4; my $id = substr $&, 1, 11 if /\-[a-zA-Z0-9_-]{11}\./; print "$n\t$id"' list.txt >gennedList.txt
# I'm using this perl version because it supposedly only prints the first match in a line
