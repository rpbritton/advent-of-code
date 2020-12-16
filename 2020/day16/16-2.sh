#!/bin/sh

INPUT=input.txt

declare -A FIELDS
declare -A VALUES
declare -A FIELDS_VALUES

while read FIELD
do
    NAME=${FIELD%: *}
    NAME=${NAME// }
    FIELDS[$NAME]=true

    RANGES=${FIELD#*: }
    while read RANGE
    do
        case $RANGE in
            or) ;;
            *-*)
                for (( VALUE=${RANGE%-*}; VALUE <= ${RANGE#*-}; VALUE++ ))
                do
                    VALUES[$VALUE]=true
                    FIELDS_VALUES["$NAME:$VALUE"]=true
                done
                ;;
        esac
    done <<<$(tr ' ' '\n' <<< $RANGES)
done <<<$(grep -P '^[a-z ]+: ' $INPUT)

declare -A POSSIBLE_FIELDS
for FIELD in "${!FIELDS[@]}"
do
    for (( NUM=0; NUM < ${#FIELDS[@]}; NUM++ ))
    do
        POSSIBLE_FIELDS[$FIELD]="${POSSIBLE_FIELDS[$FIELD]}($NUM)"
    done
done

while read TICKET
do
    INVALID=
    while read VALUE
    do
        if [[ ! ${VALUES[$VALUE]+true} ]]
        then
            INVALID=true
            break
        fi
    done <<<$(tr ',' '\n' <<< $TICKET)
    [[ $INVALID ]] && continue

    NUM=0
    while read VALUE
    do
        for FIELD in "${!FIELDS[@]}"
        do
            if [[ ! ${FIELDS_VALUES["$FIELD:$VALUE"]+true} ]]
            then
                EXISTING=${POSSIBLE_FIELDS[$FIELD]}
                POSSIBLE_FIELDS[$FIELD]=${EXISTING//($NUM)}
            fi
        done

        NUM=$((NUM+1))
    done <<<$(tr ',' '\n' <<< $TICKET)
done <<<$(sed -n '/nearby tickets:/,//p' $INPUT | sed -e '1d')

declare -A NUM_TO_FIELD

while [[ ${#FIELDS[@]} != ${#NUM_TO_FIELD[@]} ]]
do
    for FIELD in "${!POSSIBLE_FIELDS[@]}"
    do
        if [[ ${POSSIBLE_FIELDS[$FIELD]} =~ ^\([0-9]+\)$ ]]
        then
            NUM=${POSSIBLE_FIELDS[$FIELD]}
            NUM=${NUM%)}
            NUM=${NUM#(}

            NUM_TO_FIELD[$NUM]=$FIELD
            unset POSSIBLE_FIELDS[$FIELD]
            DEFINITION=$(declare -p POSSIBLE_FIELDS)
            REMOVED=${DEFINITION//($NUM)}
            eval $REMOVED
        fi
    done
done

declare -A MY_TICKET

FIELD_INDEX=0
while read VALUE
do
    MY_TICKET[${NUM_TO_FIELD[$FIELD_INDEX]}]=$VALUE
    FIELD_INDEX=$((FIELD_INDEX+1))
done <<<$(sed -n '/your ticket:/{n;p;}' $INPUT | tr ',' '\n')

RESULT=1
for FIELD in "${!MY_TICKET[@]}"
do
    if [[ $FIELD == "departure"* ]]
    then
        RESULT=$((RESULT*${MY_TICKET[$FIELD]}))
    fi
done

echo $RESULT