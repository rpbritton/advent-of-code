#!/bin/sh

INPUT=input.txt

IDS=()

while read SEAT
do
    ROW=${SEAT:0:7}
    ROW=${ROW//F/0}
    ROW=${ROW//B/1}
    ROW=$((2#$ROW))

    COL=${SEAT:7:3}
    COL=${COL//L/0}
    COL=${COL//R/1}
    COL=$((2#$COL))

    IDS+=( $((ROW*8+COL)) )
done <<<$(cat $INPUT)

IDS=( $(echo ${IDS[*]} | tr ' ' '\n' | sort -n) )

GUESS_ID=${IDS[0]}
for ID in ${IDS[@]}
do
    if [[ $GUESS_ID != $ID ]]
    then
        echo $((ID-1))
        break
    fi
    GUESS_ID=$((GUESS_ID+1))
done