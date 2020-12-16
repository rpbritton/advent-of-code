#!/bin/sh

INPUT=input.txt

declare -A TURNS
FINAL_TURN=30000000

TURN=0
LAST_NUM=0
while read NUM
do
    if [[ $TURN != 0 ]]
    then
        TURNS[$LAST_NUM]=$((TURN-1))
    fi

    LAST_NUM=$NUM
    TURN=$((TURN+1))
done <<<$(sed 's/,/\n/g' $INPUT)

for (( TURN=$TURN; TURN < $FINAL_TURN; TURN++ ))
do
    if [[ ${TURNS[$LAST_NUM]+true} ]]
    then
        NUM=$((TURN-${TURNS[$LAST_NUM]}-1))
    else
        NUM=0
    fi

    TURNS[$LAST_NUM]=$((TURN-1))
    LAST_NUM=$NUM
done

echo $NUM