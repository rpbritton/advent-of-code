#!/bin/sh

INPUT=input.txt

VALID=0

while read DETAIL
do
    NUM=$(echo $DETAIL | tr -cd ':' | wc -c)
    if [[ $NUM == 8 ]] || [[ $NUM == 7 && $DETAIL != *cid* ]]
    then
        VALID=$((VALID+1))
    fi
done <<<$(cat $INPUT | perl -0pe 's/\n(?=[a-z])/ /g')

echo $VALID