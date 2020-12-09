#!/bin/sh

INPUT=input.txt

SUM=0

while read CHOICES
do
    SIZE=$(echo $CHOICES | tr -cd ',' | wc -c)

    while read CHOICE
    do
        if [[ $CHAR != $CHOICE ]]
        then
            COUNT=0
            CHAR=$CHOICE
        fi

        COUNT=$((COUNT+1))

        if [[ $COUNT == $SIZE ]]
        then
            SUM=$((SUM+1))
        fi
    done <<<$(echo $CHOICES | tr -d ',' | grep -o . | sort)
done <<<$(cat $INPUT | perl -0pe 's/\n(?=[a-z])/,/g')

echo $SUM