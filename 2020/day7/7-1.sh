#!/bin/sh

function COUNT_BAGS() {
    while read RULE
    do
        [[ $RULE == "" ]] && continue

        BAG=$(echo $RULE | grep -oP '^(.*?)(?= bags)')
        echo $BAG
        COUNT_BAGS "$BAG"
    done <<<$(cat input.txt | grep "contain.*$1")
}

echo $(COUNT_BAGS "shiny gold" | sort | uniq -c | wc -l)