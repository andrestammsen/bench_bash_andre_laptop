 #!/bin/bash

# this skript executes all the skripts which can be found in folders with a corresponding name in its execution folder
# to specify the family of skripts to be executed, the name of the original file is passed as command line argument

# get name of original submit-skript
SKRIPT_NAME="$1"
SKRIPT_NAME_ROOT=$(echo $SKRIPT_NAME | cut -d'.' -f1)
SKRIPT_NAME_ROOT="$SKRIPT_NAME_ROOT"_""
# DEBUGGGING
#echo "$SKRIPT_NAME_ROOT"

# iterate over all folders that fit the skript name root and execute the corresponding files
for DIR_NAME in $SKRIPT_NAME_ROOT*
do
	cd ./$DIR_NAME
	FILE_NAME=""./"$DIR_NAME".sh""
	$FILE_NAME
	cd ..
done

