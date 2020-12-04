#!/bin/sh

INPUT=input.txt

VALID=0

while read RULE
do
    POS1=$(echo $RULE | cut -d " " -f 1 | cut -d "-" -f 1)
    POS2=$(echo $RULE | cut -d " " -f 1 | cut -d "-" -f 2)
    CHAR=$(echo $RULE | cut -d " " -f 2 | cut -d ":" -f 1)
    PASS=$(echo $RULE | cut -d " " -f 3)
    CHAR1=$(echo $PASS | cut -b $POS1)
    CHAR2=$(echo $PASS | cut -b $POS2)
    if [[ $CHAR1 == $CHAR && $CHAR2 != $CHAR ]] || [[ $CHAR2 == $CHAR && $CHAR1 != $CHAR ]]
    then
        # echo $NUM $MIN $MAX
        VALID=$(($VALID + 1))
    fi
done < $INPUT

echo valid: $VALID