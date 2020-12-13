#!/bin/sh

INPUT=input.txt

X=0
Y=0
SHIP_DIR=90

while read INSTRUCTION
do
    ACTION=${INSTRUCTION:0:1}
    AMOUNT=${INSTRUCTION:1}

    MOVE_VALUE=0
    MOVE_DIR=0

    case $ACTION in
        N) MOVE_VALUE=$AMOUNT; MOVE_DIR=0 ;;
        E) MOVE_VALUE=$AMOUNT; MOVE_DIR=90 ;;
        S) MOVE_VALUE=$AMOUNT; MOVE_DIR=180 ;;
        W) MOVE_VALUE=$AMOUNT; MOVE_DIR=270 ;;
        L) SHIP_DIR=$(((SHIP_DIR+(360-$AMOUNT))%360)) ;;
        R) SHIP_DIR=$(((SHIP_DIR+$AMOUNT)%360)) ;;
        F) MOVE_VALUE=$AMOUNT; MOVE_DIR=$SHIP_DIR ;;
    esac

    case $MOVE_DIR in
        0) Y=$((Y+MOVE_VALUE)) ;;
        90) X=$((X+MOVE_VALUE)) ;;
        180) Y=$((Y-MOVE_VALUE)) ;;
        270) X=$((X-MOVE_VALUE)) ;;
    esac
done <<<$(cat $INPUT)

X=${X#-}
Y=${Y#-}

echo $((X+Y))