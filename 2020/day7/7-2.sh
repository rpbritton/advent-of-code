#!/bin/sh

function COUNT_BAGS() {
    COUNT=0

    while read BAG
    do
        [[ $BAG == "" ]] && continue

        NUM=$(echo $BAG | cut -d ' ' -f 1)
        NAME=$(echo $BAG | cut -d ' ' -f 2-3)
        COUNT=$((COUNT + (NUM + NUM * $(COUNT_BAGS "$NAME"))))
    done <<<$(cat input.txt | grep -P "^$1 bag" | grep -oP '[0-9](.*?)bag')

    echo $COUNT
}

COUNT_BAGS "shiny gold"
# echo $COUNT_BAGS "shiny gold"