#!/bin/bash

MAX_CUM_CAL=0
CUM_CAL=0

while read -r CAL
do
    if [[ -z $CAL ]]
    then
        if (( $CUM_CAL > $MAX_CUM_CAL ))
        then
            MAX_CUM_CAL=$CUM_CAL
        fi
        CUM_CAL=0
    else
        CUM_CAL=$(($CUM_CAL + $CAL))
    fi
done < input.txt

echo $MAX_CUM_CAL
