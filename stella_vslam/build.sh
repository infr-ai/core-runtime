#!/usr/bin/env bash

export SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

git clone https://github.com/stella-cv/stella_vslam.git && \
    cd stella_vslam && git checkout a18add7
docker build -t stella_vslam -f Dockerfile.socket .
