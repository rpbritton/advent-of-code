#!/bin/sh

INPUT=input.txt

SUM=0

while read CHOICES
do
    COUNT=$(echo $CHOICES | grep -o . | sort | tr -d '\n' | tr -s 'a-z' | wc -c)
    SUM=$((SUM+COUNT))
done <<<$(cat $INPUT | perl -0pe 's/\n(?=[a-z])//g')

echo $SUM