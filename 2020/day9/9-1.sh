#!/bin/sh

INPUT=input.txt
LINE_NUM=26
NUM_LINES=$(wc -l < $INPUT)

function TEST_LINE() {
    TARGET=$(sed "$1!d" $INPUT)
    CURSOR_LINE=$(($1-25))
    END_LINE=$(($1-1))

    while [[ $CURSOR_LINE -lt $END_LINE ]]
    do
        NUM1=$(sed "$CURSOR_LINE!d" $INPUT)

        while read NUM2
        do
            if [[ $(($NUM1 + $NUM2)) == $TARGET ]]
            then
                return
            fi
        done <<<$(sed "$CURSOR_LINE,$END_LINE!d" $INPUT)

        CURSOR_LINE=$((CURSOR_LINE+1))
    done

    echo $TARGET
}

while [[ $LINE_NUM -le $NUM_LINES ]]
do
    TEST_LINE $LINE_NUM

    LINE_NUM=$((LINE_NUM+1))
done