#!/bin/sh

INPUT=input.txt

VALID=0

while read DETAIL
do
    DETAIL="$DETAIL "
    if [[ $DETAIL =~ byr:(19[2-9][0-9]|200[0-2])( ) ]] && \
        [[ $DETAIL =~ iyr:(201[0-9]|2020)( ) ]] && \
        [[ $DETAIL =~ eyr:(202[0-9]|2030)( ) ]] && \
        [[ $DETAIL =~ hgt:((1[5-9][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)( ) ]] && \
        [[ $DETAIL =~ hcl:#[0-9a-f]{6}( ) ]] && \
        [[ $DETAIL =~ ecl:(amb|blu|brn|gry|grn|hzl|oth)( ) ]] && \
        [[ $DETAIL =~ pid:[0-9]{9}( ) ]]
    then
        VALID=$((VALID+1))
    fi
done <<<$(cat $INPUT | perl -0pe 's/\n(?=[a-z])/ /g')

echo $VALID