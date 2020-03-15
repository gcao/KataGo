#!/bin/bash -eu

dir=$(pwd)

round=1

while true
do
    echo ==== Round $round start ====
    echo
    start=$SECONDS

    echo ==== Round $round self-play ====
    echo
    cpp/katago selfplay -output-dir shared/selfplay -models-dir shared/models -config-file cpp/configs/selfplay1.cfg

    echo ==== Round $round shuffle and export ====
    echo
    cd python
    ./selfplay/shuffle_and_export_loop.sh CAO ../shared/ ../shared/tmp 4 0

    echo ==== Round $round end ====
    seconds=$((SECONDS - start))
    printf "Time: %02d:%02d:%02d" $(((seconds / 3600))) $(((SECONDS % 3600) / 60)) $((seconds % 60))
    echo

    sleep 10

    round=$((round + 1))
done
