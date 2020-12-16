#!/bin/sh

INPUT=input.txt

declare -A FIELDS

while read FIELD
do
    NAME=${FIELD%: *}
    NAME=${NAME// }

    RANGES=${FIELD#*: }
    while read RANGE
    do
        case $RANGE in
            or) ;;
            *-*)
                for (( VALUE=${RANGE%-*}; VALUE <= ${RANGE#*-}; VALUE++ ))
                do
                    FIELDS[$VALUE]=true
                done
                ;;
        esac
    done <<<$(tr ' ' '\n' <<< $RANGES)
done <<<$(grep -P '^[a-z ]+: ' $INPUT)

SUM=0
while read TICKET
do
    while read VALUE
    do
        if [[ ! ${FIELDS[$VALUE]+true} ]]
        then
            SUM=$((SUM+VALUE))
        fi
    done <<<$(tr ',' '\n' <<< $TICKET)
done <<<$(sed -n '/nearby tickets:/,//p' $INPUT | sed -e '1d')

echo $SUM