#!/bin/sh

INPUT="input.txt"

PRODUCT=1

COUNT_TREES() {
    X=$((-$1))
    Y=$((-1))
    TREES=0

    while read LAND
    do
        Y=$((1+Y))
        if [[ $((Y%$2)) != 0 ]]
        then
            continue
        fi

        X=$((($1+X)%${#LAND}))
        if [[ ${LAND:X:1} == "#" ]]
        then
            TREES=$((1+TREES))
        fi
    done < $INPUT

    PRODUCT=$((PRODUCT*TREES))
}

COUNT_TREES 1 1
COUNT_TREES 3 1
COUNT_TREES 5 1
COUNT_TREES 7 1
COUNT_TREES 1 2

echo $PRODUCT