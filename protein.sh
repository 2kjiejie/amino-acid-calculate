#!/bin/bash

while getopts “f:o:h” option
do
        case $option in
                f) inputfile=$OPTARG;;
                o) outputfile=$OPTARG;;
                h) echo help
        esac
done

amino_array=('G' 'P' 'A' 'V' 'L' 'I' 'M' 'C' 'F' 'Y' 'W' 'H' 'K' 'R' 'Q' 'N' 'E' 'D' 'S' 'T')

echo -e "amino_acid\tcount\tpercentage" > $outputfile

all=$(grep -v ">" $inputfile | grep -o .| wc -l)
#echo $all
for i in {0..19}
do
        echo $i
        amino=${amino_array[$i]}
        count=$(grep -v ">" $inputfile | grep -o $amino | grep -c $amino)
        expr $count / $all
        percentage=`awk 'BEGIN{printf "%.3f%%\n",('$count'/'$all')*100}'`
        #echo $percentage
        echo -e  $amino'\t'$count'\t'$percentage >> $outputfile
done
