#!/bin/bash

CUM_CALS=()
CUM_CAL=0

while read -r CAL
do
    if [[ -z $CAL ]]
    then
        CUM_CALS+=( $CUM_CAL )
        CUM_CAL=0
    else
        CUM_CAL=$(($CUM_CAL + $CAL))
    fi
done < input.txt

CUM_CALS=( $(echo ${CUM_CALS[@]} | xargs -n1 | sort -nr | xargs) )
echo $(( ${CUM_CALS[0]} + ${CUM_CALS[1]} + ${CUM_CALS[2]} ))
