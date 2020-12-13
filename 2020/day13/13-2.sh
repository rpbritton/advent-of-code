#!/bin/sh

INPUT=input.txt

TIME=0
OFFSET=-1

KEY=0
MULTIPLIER=1

while read ID
do
    OFFSET=$((OFFSET+1))
    [[ $ID == 'x' ]] && continue

    for (( TMP_KEY=0; $(((TIME+OFFSET)%ID)) != 0; TMP_KEY=$((TMP_KEY+1)) ))
    do
        TIME=$((MULTIPLIER*TMP_KEY+KEY))
    done

    KEY=$TIME
    MULTIPLIER=$((MULTIPLIER*ID))
done <<<$(sed '2!d' $INPUT | sed 's/,/\n/g')

echo $TIME