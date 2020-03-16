#!/bin/bash -eu

dir=$(pwd)

round=1

while true
do
    echo ==== Round $round train ====
    echo
    cd python
    ./selfplay/train.sh ../shared/ CAO b6c96 main -lr-scale 1.0
    cd ..

    echo ==== Round $round gatekeeper ====
    echo
    cpp/katago gatekeeper \
      -rejected-models-dir     shared/rejectedmodels \
      -accepted-models-dir     shared/models \
      -sgf-output-dir          shared/gatekeepersgf \
      -test-models-dir         shared/modelstobetested \
      -config-file             cpp/configs/gatekeeper1.cfg \
      -quit-if-no-nets-to-test 1

    echo ==== Round $round end ====
    seconds=$((SECONDS - start))
    printf "Time: %02d:%02d:%02d" $(((seconds / 3600))) $(((SECONDS % 3600) / 60)) $((seconds % 60))
    echo

    sleep 10

    round=$((round + 1))
done
