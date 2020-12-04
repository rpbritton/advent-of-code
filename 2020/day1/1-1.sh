#!/bin/sh

INPUT=input.txt

while read CODE1
do
    while read CODE2
    do
        if [[ $(($CODE1 + $CODE2)) == 2020 ]]
        then
            echo $(($CODE1 * $CODE2))
            exit
        fi
    done < $INPUT
done < $INPUT