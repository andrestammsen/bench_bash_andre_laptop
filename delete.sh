#!/bin/bash

# this file takes the name of a submit file and a maximum number of nodes as arguments and
# deletes all folders and the files contained within them that are related to the original submit file

# read command line arguments
SOURCE_NAME="$1"
MAX_NUM="$2"

# get name of original submit skript
SKRIPT_NAME="$1"
SKRIPT_NAME_ROOT=$(echo $SKRIPT_NAME | cut -d'.' -f1)
SKRIPT_NAME_ROOT="$SKRIPT_NAME_ROOT"_""

# iterate over all folders that fit the skript name root and execute the corresponding files
for DIR_NAME in $SKRIPT_NAME_ROOT*
do
        cd $DIR_NAME
        FILE_NAME="$DIR_NAME".sh""
        if [ -e "$FILE_NAME" ]
	then
		# DEBUGGING
		rm $FILE_NAME
		echo "file $FILE_NAME deleted"
	fi
        cd ..
	rm -r $DIR_NAME
	echo "folder $DIR_NAME deleted"
done

