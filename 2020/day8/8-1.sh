#!/bin/sh

LINE_NUM=1
declare -A INSTRUCTIONS
ACCUMULATOR=0

while true
do
    [[ ${INSTRUCTIONS[$LINE_NUM]+true} ]] && break

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
            ;;
    esac
done

echo $ACCUMULATOR