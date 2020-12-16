#!/bin/sh

INPUT=input.txt

declare -a ANDS
declare -a ORS
declare -A MEMORY

while read INSTRUCTION
do
    case $INSTRUCTION in
        mask*)
            MASK=${INSTRUCTION#*=}
            EXTRA_OR=$((2#${MASK//X/0}))

            MASK=${MASK//[01]/N}
            VARIATIONS=${MASK//[^X]}
            VARIATIONS=$((2**${#VARIATIONS}))
            ANDS=()
            ORS=()
            for (( INDEX=0; INDEX < $VARIATIONS; INDEX++ ))
            do
                NEW_MASK=$(echo $MASK | rev)
                BINARY=$(echo "obase=2;$INDEX" | bc)
                for (( CHAR_INDEX=${#BINARY}-1; CHAR_INDEX >= 0; CHAR_INDEX-- ))
                do
                    CHAR=${BINARY:$CHAR_INDEX:1}
                    NEW_MASK=${NEW_MASK/X/$CHAR}
                done
                NEW_MASK=${NEW_MASK//X/0}
                NEW_MASK=$(echo $NEW_MASK | rev)
                ANDS+=( $((2#${NEW_MASK//N/1})) )
                ORS+=( $((2#${NEW_MASK//N/0})) )
            done
            ;;
        mem*)
            LOCATION=${INSTRUCTION#*[}
            LOCATION=${LOCATION%]*}
            VALUE=${INSTRUCTION#*=}
            for INDEX in "${!ANDS[@]}"
            do
                MEMORY[$(((LOCATION & ${ANDS[$INDEX]} | ${ORS[$INDEX]}) | EXTRA_OR))]=$VALUE
            done
            ;;
    esac
done <<<$(cat $INPUT | tr -d ' ')

RESULT=0
for VALUE in "${MEMORY[@]}"
do
    RESULT=$((RESULT+VALUE))
done

echo $RESULT
