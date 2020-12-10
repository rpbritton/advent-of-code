#!/bin/sh

INPUT=input.txt

TARGET=400480901

CURSOR=1
NUM_LINES=$(wc -l < $INPUT)

while [[ $LINE_NUM -le $NUM_LINES ]]
do
    COUNTER=0
    CURSOR_START=$CURSOR

    while read NUM
    do
        COUNTER=$((COUNTER+NUM))
        if [[ $COUNTER == $TARGET ]]
        then
            break 2
        elif [[ $COUNTER -gt $TARGET ]]
        then
            break
        fi
        CURSOR=$((CURSOR-1))
    done <<<$(sed "1,$CURSOR!d" $INPUT | tac)

    CURSOR=$((CURSOR_START+1))
done

sed "$CURSOR,$CURSOR_START!d" $INPUT | sort -n | sed '1p;$!d' | paste -s -d '+' - | bc