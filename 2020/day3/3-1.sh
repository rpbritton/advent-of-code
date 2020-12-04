#!/bin/sh

INPUT="input.txt"

X=0
Y=0
TREES=0

while read LAND
do
    if [[ ${LAND:X:1} == "#" ]]
    then
        TREES=$((1+TREES))
    fi
    X=$(((3+X)%${#LAND}))
    Y=$((1+Y))
done < $INPUT

echo $TREES