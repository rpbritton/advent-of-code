#!/bin/bash

PRIORITY_SUM=0

while read -r ITEMS
do
    FIRST=${ITEMS:0:${#ITEMS}/2}
    SECOND=${ITEMS:${#ITEMS}/2}

    SHARED_ITEM=$(tr -dc $FIRST <<< $SECOND | fold -w1 | sort -u)
    ASCII=$(printf %d \'$SHARED_ITEM)
    PRIORITY=$((($ASCII < 91)) && echo $(($ASCII - (65-27))) || echo $(($ASCII - (97-1))))
    
    PRIORITY_SUM=$(($PRIORITY_SUM + $PRIORITY))
done < $([[ -z $1 ]] && echo "input.txt" || echo "$1")

echo $PRIORITY_SUM
