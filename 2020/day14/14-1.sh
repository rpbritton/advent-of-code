#!/bin/sh

INPUT=input.txt

declare -A MEMORY

while read INSTRUCTION
do
    case $INSTRUCTION in
        mask*)
            MASK=${INSTRUCTION#*=}
            OR=$((2#${MASK//X/0}))
            AND=$((2#${MASK//X/1}))
            ;;
        mem*)
            LOCATION=${INSTRUCTION#*[}
            LOCATION=${LOCATION%]*}
            VALUE=${INSTRUCTION#*=}
            MEMORY[$LOCATION]=$(((VALUE & AND) | OR))
            ;;
    esac
done <<<$(cat $INPUT | tr -d ' ')

RESULT=0
for VALUE in "${MEMORY[@]}"
do
    RESULT=$((RESULT+VALUE))
done

echo $RESULT
