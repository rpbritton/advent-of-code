#!/bin/bash

declare -A MAP=( \
    ["A"]=0 ["B"]=1 ["C"]=2 \
    ["X"]=0 ["Y"]=1 ["Z"]=2 \
)

declare -A POINT_CHOICE=(["0"]=1 ["1"]=2 ["2"]=3)
declare -A POINT_RESULT=(["0"]=3 ["1"]=6 ["2"]=0)

TOTAL_SCORE=0

while read -r STRAT
do
    STRAT=($STRAT)
    
    THEIRS=${MAP[${STRAT[0]}]}
    OURS=${MAP[${STRAT[1]}]}
    RESULT=$((($OURS - $THEIRS + 3) % 3))
    
    SCORE=$((${POINT_CHOICE[$OURS]} + ${POINT_RESULT[$RESULT]}))
    
    TOTAL_SCORE=$(($TOTAL_SCORE + $SCORE))
done < $([[ -z $1 ]] && echo "input.txt" || echo "$1")

echo $TOTAL_SCORE
