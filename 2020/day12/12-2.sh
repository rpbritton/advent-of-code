#!/bin/sh

INPUT=input.txt

X=0
Y=0

WAY_X=10
WAY_Y=1

while read INSTRUCTION
do
    ACTION=${INSTRUCTION:0:1}
    AMOUNT=${INSTRUCTION:1}

    WAY_DIR=0
    MOVE_AMOUNT=0

    case $ACTION in
        N) WAY_Y=$((WAY_Y+$AMOUNT)) ;;
        E) WAY_X=$((WAY_X+$AMOUNT)) ;;
        S) WAY_Y=$((WAY_Y-$AMOUNT)) ;;
        W) WAY_X=$((WAY_X-$AMOUNT)) ;;
        L) WAY_DIR=$((360-$AMOUNT)) ;;
        R) WAY_DIR=$(($AMOUNT)) ;;
        F) MOVE_AMOUNT=$AMOUNT ;;
    esac

    TMP_X=$WAY_X
    TMP_Y=$WAY_Y

    case $WAY_DIR in
        90) WAY_X=$((TMP_Y)); WAY_Y=$((TMP_X*-1)) ;;
        180) WAY_X=$((TMP_X*-1)); WAY_Y=$((TMP_Y*-1)) ;;
        270) WAY_X=$((TMP_Y*-1)); WAY_Y=$((TMP_X)) ;;
    esac

    X=$((X+WAY_X*MOVE_AMOUNT))
    Y=$((Y+WAY_Y*MOVE_AMOUNT))
done <<<$(cat $INPUT)

X=${X#-}
Y=${Y#-}

echo $((X+Y))