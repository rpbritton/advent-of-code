#!/bin/sh

INPUT=input.txt

declare -a SEATS

INDEX=0
while read SPOT
do
    SEATS[$INDEX]=$SPOT
    INDEX=$((INDEX+1))
done <<<$(cat $INPUT | grep -o .)

SIZE=${#SEATS[@]}
WIDTH=$(wc -L < $INPUT)
HEIGHT=$((SIZE/WIDTH))

NEAR_SEATS=( -1,-1 -1,0 -1,1 0,-1 0,1 1,-1 1,0 1,1 )

function PROCESS() {
    SEATS_CHANGED=0
    TMP_SEATS=(${SEATS[@]})

    for INDEX in ${!SEATS[@]}
    do
        SEAT=${SEATS[$INDEX]}
        [[ $SEAT == '.' ]] && continue

        NUM_FULL=0
        for OFFSET in ${NEAR_SEATS[@]}
        do
            ROW=$(((INDEX/WIDTH)+${OFFSET%,*}))
            COL=$(((INDEX%WIDTH)+${OFFSET#*,}))
            [[ $COL -lt 0 || $COL -ge $WIDTH || \
                $ROW -lt 0 || $ROW -ge $HEIGHT ]] && continue
            [[ ${SEATS[$((ROW*WIDTH+COL))]} == '#' ]] && NUM_FULL=$((NUM_FULL+1))
        done

        if [[ $SEAT == 'L' && $NUM_FULL == 0 ]]
        then
            TMP_SEATS[$INDEX]='#'
        elif [[ $SEAT == '#' && $NUM_FULL -ge 4 ]]
        then
            TMP_SEATS[$INDEX]='L'
        else
            continue
        fi

        SEATS_CHANGED=$((SEATS_CHANGED+1))
    done

    SEATS=(${TMP_SEATS[@]})
}

SEATS_CHANGED=1
while [[ $SEATS_CHANGED != 0 ]]
do
    PROCESS
    echo changed: $SEATS_CHANGED
done

echo ${SEATS[@]} | tr -cd "#" | wc -c