#!/bin/sh

INPUT=input.txt

JOLT_1=0
JOLT_2=0
JOLT_3=0

JOLTAGE=0

while read RATING
do
    DIFFERENCE=$((RATING-JOLTAGE))
    case $DIFFERENCE in
        1) JOLT_1=$(($JOLT_1+1)) ;;
        2) JOLT_2=$(($JOLT_2+1)) ;;
        3) JOLT_3=$(($JOLT_3+1)) ;;
    esac
    JOLTAGE=$RATING
done <<<$(cat $INPUT | sort -n)

JOLT_3=$(($JOLT_3+1))

echo $(($JOLT_1*$JOLT_3))