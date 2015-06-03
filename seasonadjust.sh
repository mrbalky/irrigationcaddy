#!/bin/bash
#-----------------------------------------------------------------------
# Set an IrrigationCaddy program, and optionally adjust zone run times
# proportionally based on a percentage of the run times defined in the
# program.
#-----------------------------------------------------------------------

function usage {
    echo "
USAGE:
    `basename $0` [-a <pct>] [-p <zone program>] <IrrigationCaddy host>

EXAMPLE:
    `basename $0` -a 30 -p `dirname $0`/sample_settings 192.168.1.60
"
    exit 1
}

# Options
while getopts "a:p:" flag
do
   case "$flag" in
      a) adjustPct=$OPTARG
         ;;
      p) programSettings=$OPTARG
         ;;
      *) usage
         ;;
   esac
done
shift $((OPTIND-1))
programSettings=${programSettings:-`dirname $0`/program1_settings}
adjustPct=${adjustPct:-100}

# IrrigationCaddy host name or ip address is required
host="$1"

# Check!
if [ $# -lt 1 ]; then
    usage
fi

# Include the prgramming settings
if [ ! -e $programSettings ]; then
    echo Program settings file $programSettings not found
    exit 1
fi
. $programSettings

# every n days and even/odd handling
if [ "$ndays" != "" ] && [ $ndays -gt 0 ]; then
    days="&everyNDays=$ndays"
elif [ "$evenOdd" != "" ]; then
    days="&evenodd=$evenOdd"
fi

# Start building post data
data="doProgram=1&allowRun=$allowRun&pgmNum=$prog$days"

# Run on these days
for day in ${runDays[@]}; do
    data="$data&day_$day=1"
done

# Up to 5 start times each day
let n=0
for t in "${startTimes[@]}"; do
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
    data="$data$stime&stStat$n=1"
    #echo $data
    let n=$n+1
done

# Finaaly, the zone run times, with percentage adjust
for n in {0..8}; do
    t=${zoneMins[$n]}
    t=$(($t*$adjustPct/100))
    n=$(($n+1))
    dur="&z${n}durHr=0&z${n}durMin=$t"
    #echo $dur
    data="$data$dur"
done

# Go babe!
echo wget -S -T 30 -t 1 -O - --post-data "$data" "http://$host/program.htm"
wget -S -T 30 -t 1 -O - --post-data "$data" "http://$host/program.htm"
