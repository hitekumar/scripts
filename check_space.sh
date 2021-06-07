#!/bin/bash

# This script will check the space used in $1 or CWD



DIR=`realpath $1`
OUTPUT=${DIR}/check_space.txt

if [ -f $OUTPUT ]
then
    rm -f $OUTPUT
fi
dirlist=`find ${DIR} -type d -maxdepth 1 -printf "%T@ %Tc %p\n" | sort | rev | cut -d ' ' -f1 | rev`
date > ${OUTPUT}
for i in ${dirlist} 
do  
    SIZE=`du $i -sh`
    echo ${SIZE} >> ${OUTPUT}
    echo "${SIZE}"
done
echo "Output is ${OUTPUT}"
