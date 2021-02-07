#!/usr/bin/env bash

cachefile=~/.cache/fzf_mru/cache.txt
cat $cachefile | while read line
do
    if [[ ! -f $line ]]; then
        echo "$line"
    fi
done
