#!/bin/bash

# base and default values
prog=1
ndays=2
zoneMins=(20 20 20 10 10 19 12 10 0)
startTimes=(21:00 0:00 0:00 0:00 0:00)
allowRun=yes

host="$1"
pct=${2:-100}

data="doProgram=1&allowRun=$allowRun&everyNDays=$ndays&pgmNum=$prog"

for n in {0..4}; do
    t=${startTimes[$n]}
    hr=${t%:*}
    mn=${t#*:}
    merid=am
    if (( $hr >= 12 )); then
        let hr=$hr-12
        merid=pm
    fi
    if (( $hr == 0 )); then
        hr=12
    fi
    stime="&stHr$n=$hr&startTime$n=$hr:$mn+$merid&stMin$n=$mn&merid$n=$merid"
    #echo $stime
    data="$data$stime"
    #echo $data
done

for n in {0..8}; do
    t=${zoneMins[$n]}
    t=$(($t*$pct/100))
    n=$(($n+1))
    dur="&z${n}durHr=0&z${n}durMin=$t"
    #echo $dur
    data="$data$dur"
done

echo wget -S -T 30 -t 1 -O - --post-data "$data" "http://$host/program.htm"
wget -S -T 30 -t 1 -O - --post-data "$data" "http://$host/program.htm"
