#!/bin/bash
#-----------------------------------------------------------------------
# Run a zone for a number of minutes, a number of times, waiting some
# interval between runs.
# Meant to help blow out a zone when using a compressor that can't do it
# all in one go, and needs some recovery time between runs.
#-----------------------------------------------------------------------

function usage {
    echo "
USAGE:
    `basename $0` [-i <interval in seconds>] [-t <zone run time in minutes>] [-c <cycles to run>] <IrrigationCaddy host> <zone>
"
    exit 1
}

while getopts "t:i:c:" flag
do
   case "$flag" in
      t) zoneTime=$OPTARG
         ;;
      i) intervalSeconds=$OPTARG
         ;;
      c) count=$OPTARG
         ;;
      *) usage
         ;;
   esac
done
shift $((OPTIND-1))
zoneTime=${zoneTime:-1}
intervalSeconds=${intervalSeconds:-430}
count=${count:-1}

if [ $# -lt 2 ]; then
    usage
fi

function countdown
{
   for n in `seq $1 -1 0`; do
      printf "\r- %3d -     " $n
      sleep 1
   done
   echo
}

# IrrigationCaddy host name or ip address, and zone number are required
host=$1
zone=$2

for n in `seq $count -1 1`; do
    echo
    echo
    echo `dirname $0`/runnow.sh $host $zone $zoneTime
    `dirname $0`/runnow.sh $host $zone $zoneTime
    echo "$(($n-1)) round(s) left"
    echo "Sleeping $intervalSeconds..."
    countdown $intervalSeconds
done
