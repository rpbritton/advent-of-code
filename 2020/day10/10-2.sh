#!/bin/sh

INPUT=input.txt

LINE_NUM=$(($(wc -l < $INPUT)-1))

declare -A MAP
MAP[$(cat $INPUT | sort -n | sed '$!d')]=1

function CALC() {
    WAYS=0
    JOLTAGE=$1

    while read RATING
    do
        [[ $((RATING-JOLTAGE)) -gt 3 ]] && break

        PATH_WAYS=${MAP[$RATING]}
        WAYS=$((WAYS+PATH_WAYS))
    done <<<$(cat $INPUT | sort -n | sed "$2,\$!d")

    MAP[$JOLTAGE]=$WAYS
}

while [[ $LINE_NUM -gt 0 ]]
do
    CALC $(cat $INPUT | sort -n | sed "$LINE_NUM!d") $((LINE_NUM+1))
    LINE_NUM=$((LINE_NUM-1))
done

CALC 0 1

echo $WAYS