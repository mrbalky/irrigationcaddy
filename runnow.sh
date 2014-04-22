#!/bin/bash

HOST="$1"
ZONE=${2:-1}
MINS=${3:-1}

# Build post data like so:
# doProgram=1&runNow=1&pgmNum=4&z1durHr=0&z1durMin=1&z2durHr=0&z2durMin=0&z3durHr=0&z3durMin=0&z4durHr=0&z4durMin=0&z5durHr=0&z5durMin=0&z6durHr=0&z6durMin=0&z7durHr=0&z7durMin=0&z8durHr=0&z8durMin=0&z9durHr=0&z9durMin=0

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
