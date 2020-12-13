#!/bin/sh

INPUT=input.txt

TIME=$(sed '1!d' $INPUT)

CLOSEST_BUS=0
CLOSEST_TIME=0

while read BUS
do
    [[ $BUS == 'x' ]] && continue

    BUS_TIME=$((TIME/BUS*BUS+BUS))

    if [[ $CLOSEST_TIME == 0 || $BUS_TIME -lt $CLOSEST_TIME ]]
    then
        CLOSEST_BUS=$BUS
        CLOSEST_TIME=$BUS_TIME
    fi
done <<<$(sed '2!d' $INPUT | sed 's/,/\n/g')

echo $((CLOSEST_BUS*(CLOSEST_TIME-TIME)))