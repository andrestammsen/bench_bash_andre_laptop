#!/bin/bash

# example file for a job is changed and saved many times to automatize the task execution with varying numbers of CPUs
# start
#echo "start of skript ----------------------------------------------------------------"

# number of cores per node
CORES_PER_NODE=24

# read name of source file passed as console argument
SOURCE_NAME="$1"
#echo "name source file: $SOURCE_NAME"

# read the desird maximum number of CPUs
NUM_PROCESSES="$2"
#echo "maximum number of processes: $NUM_PROCESSES"

# set variables to find keywords in the original skript to replace the respective values in that line of the file
JOB_NAME="job-name"
NODES="nodes"
NTASKS="ntasks"
NTASKS_PER_NODE="ntasks-per-node"
OUTPUT="output"
ERROR="error"
TIME="time"

# extract name of the source file without file extension and an additional underscore
FILE_NAME="file-name.txt"
FILE_NAME_ROOT=$(echo $SOURCE_NAME | cut -d'.' -f1)
FILE_NAME_ROOT="$FILE_NAME_ROOT"_""
DIR_NAME=$FILE_NAME_ROOT

# create the necessary submit-files incrementing the number of CPUs after each iteration step
for((iter=1; iter<=$NUM_PROCESSES; iter++))
do
	# create name for new file according to the number of nodes that should be used
	FILE_NAME="$FILE_NAME_ROOT$NAME$iter"
	FILE_NAME="$FILE_NAME".sh""
	# DEBUGGING
	#echo $FILE_NAME

	# calculate number of nodes and number of tasks per node
	NODES=$((($iter-1)/$CORES_PER_NODE + 1))
	NTASKS_PER_NODE=$(($iter/$NODES))

	# calculate the necessary format for the time
	hours=$(($iter/60))
	minutes=$(($iter%60))
	zero_minutes=""
	zero_hours=""
	if [ $minutes -lt 10 ]
	then
		zero_minutes="0"
	fi
	if [ $hours -lt 10 ]
	then
		zero_hours="0"
	fi
	TIME="$zero_hours$hours":"$zero_minutes$minutes":00""
	# DEBUGGING
	#echo "time: $TIME"

	# iterate over the lines of the original file and replace values
	cat $SOURCE_NAME | while read line; do
		if echo "$line" | grep -q "job-name="; then
			echo "${line/original/$iter}" >> "$FILE_NAME"
		elif echo "$line" | grep -q "nodes="; then
                        echo "${line/original/$NODES}" >> "$FILE_NAME"
		elif echo "$line" | grep -q "ntasks="; then
			echo "${line/original/$iter}" >> "$FILE_NAME"
        	elif echo "$line" | grep -q "ntasks-per-node="; then
	                echo "${line/original/$NTASKS_PER_NODE}" >> "$FILE_NAME"
		elif echo "$line" | grep -q "output="; then
			echo "${line/original/$iter}" >> "$FILE_NAME"
		elif echo "$line" | grep -q "error="; then
			echo "${line/original/$iter}" >> "$FILE_NAME"
		elif echo "$line" | grep -q "time="; then
			echo "${line/original/$TIME}" >> "$FILE_NAME"
		else
			echo "$line" >> "$FILE_NAME"
		fi
	done
	chmod 700 $FILE_NAME
	DIR_NAME="$FILE_NAME_ROOT$iter"
	mkdir $DIR_NAME
	# DEBUGGING
	echo "folder $DIR_NAME created"
	mv $FILE_NAME $DIR_NAME
        echo "file $FILE_NAME created"
done

# end
#echo "end of skript ------------------------------------------------------------------"
