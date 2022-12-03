#!/bin/bash

PRIORITY_SUM=0

while read ELF_1; read ELF_2; read ELF_3
do
    BADGE=$(tr -dc $ELF_1 <<< $ELF_2 | tr -dc $ELF_3 | fold -w1 | sort -u)

    ASCII=$(printf %d \'$BADGE)
    PRIORITY=$((($ASCII < 91)) && echo $(($ASCII - (65-27))) || echo $(($ASCII - (97-1))))
    
    PRIORITY_SUM=$(($PRIORITY_SUM + $PRIORITY))
done < $([[ -z $1 ]] && echo "input.txt" || echo "$1")

echo $PRIORITY_SUM
