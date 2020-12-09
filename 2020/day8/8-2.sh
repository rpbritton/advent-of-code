#!/bin/sh

LINE_NUM=1
declare -A INSTRUCTIONS
ACCUMULATOR=0

NUM_LINES=$(wc -l < input.txt)

while true
do
    [[ $LINE_NUM -gt $NUM_LINES ]] && break

    INSTRUCTIONS[$LINE_NUM]=true

    LINE=$(sed "$LINE_NUM!d" input.txt)
    OPCODE=${LINE% *}
    OPERAND=${LINE#* }

    case $LINE in
        nop*)
            LINE_NUM=$((LINE_NUM+1))
            ;;
        acc*)
            ACCUMULATOR=$((ACCUMULATOR+OPERAND))
            LINE_NUM=$((LINE_NUM+1))
            ;;
        jmp*)
            LINE_NUM=$((LINE_NUM+OPERAND))
            [[ ${INSTRUCTIONS[$LINE_NUM]+true} ]] && LINE_NUM=$((LINE_NUM-OPERAND+1))
            ;;
    esac
done

echo $ACCUMULATOR