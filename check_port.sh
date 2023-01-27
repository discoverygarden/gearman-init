#!/bin/bash
# Script to test port.

USAGE="Usage: -h [host] -p [port] -i [interval in seconds]"
MESSAGE="Check port"

# Exit codes.
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

HOST="localhost"
PORT=3306
INTERVAL=15



# Using getopts to use options, all required and must not be empty.
while getopts ":h:p:i:" option; do
  case $option in
    h)
      HOST=$OPTARG
      ;;
    p)
      PORT=$OPTARG
      ;;
    i)
      INTERVAL=$OPTARG
      ;;
    \?)
      echo "$USAGE" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done

for i in {1..10}
do
  /bin/nc -z $HOST $PORT
  exit_code=$?

  if [ $exit_code -eq 0 ]
  then
    echo "Service Running on Port $PORT"
    break
  else
    echo "Service Not Running on Port $PORT"
  fi
  sleep $INTERVAL
done

exit $exit_code
