#!/bin/sh

INPUT=input.txt

INVALID=0

while read RULE
do
    MIN=$(echo $RULE | cut -d " " -f 1 | cut -d "-" -f 1)
    MAX=$(echo $RULE | cut -d " " -f 1 | cut -d "-" -f 2)
    CHAR=$(echo $RULE | cut -d " " -f 2 | cut -d ":" -f 1)
    PASS=$(echo $RULE | cut -d " " -f 3)
    NUM=$(echo $PASS | tr -cd $CHAR | wc -c)
    if [[ $NUM -lt $MIN ]] || [[ $NUM -gt $MAX ]]
    then
        # echo $NUM $MIN $MAX
        INVALID=$(($INVALID + 1))
    fi
done < $INPUT

echo valid: $((1000 - $INVALID))