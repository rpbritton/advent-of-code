#!/bin/sh

INPUT=input.txt

declare -A CODES

while read CODE1
do
    while read CODE2
    do
        while read CODE3
        do
            if [[ $(($CODE1 + $CODE2 + $CODE3)) == 2020 ]]
            then
                echo $(($CODE1 * $CODE2 * $CODE3))
                exit
            fi
        done < $INPUT
    done < $INPUT
done < $INPUT