#!/bin/bash

HOST="$1"
ZONE=${2:-1}
MINS=${3:-1}

DATA="doProgram=1&runNow=1&pgmNum=4"
for z in {1..9}; do
    if [ "$ZONE" == $z ]; then
        DATA="$DATA&z${z}durHr=0&z${z}durMin=$MINS"
    else
        DATA="$DATA&z${z}durHr=0&z${z}durMin=0"
    fi
done

#POST /program.htm HTTP/1.1
echo wget -S -T 30 -t 1 -O - --post-data "$DATA" "http://$HOST/program.htm"
wget -S -T 30 -t 1 -O - --post-data "$DATA" "http://$HOST/program.htm"
