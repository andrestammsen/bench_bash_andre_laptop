#!/bin/bash

# this file takes the name of a submit file and a maximum number of nodes as arguments and
# deletes all folders and the files contained within them that are related to the original submit file
# in the end I wrote another file which only takes the submit file as argument and iterates over all files that
# math that name to avoid having to enter the correct number of files to prevent errors from happening

# read command line arguments
SOURCE_NAME="$1"
MAX_NUM="$2"

## extract name of the source file without file extension and an additional underscore
FILE_NAME_ROOT=$(echo $SOURCE_NAME | cut -d'.' -f1)
FILE_NAME_ROOT="$FILE_NAME_ROOT"_""
DIR_NAME=$FILE_NAME_ROOT

# iterate over all folders that fit file name root and execute the corresponding files
for ((iter=1; iter<=$MAX_NUM; iter++))
do
        DIR_NAME="$FILE_NAME_ROOT$iter"
       if [ -d "$DIR_NAME" ]
	then
		cd $DIR_NAME
		FILE_NAME="$FILE_NAME_ROOT$iter".sh""
		if [ -e "$FILE_NAME" ]
		then
			rm $FILE_NAME
		fi
		cd ..
		rm -r $DIR_NAME
		echo "directory $DIR_NAME and file $FILE_NAME deleted"
	fi
done

