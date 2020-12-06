#!/bin/sh

INPUT=input.txt

HIGHEST=0

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

    ID=$((ROW*8+COL))
    if [[ ID -gt $HIGHEST ]]
    then
        HIGHEST=$ID
    fi
done <<<$(cat $INPUT)

echo $HIGHEST