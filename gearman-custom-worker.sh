#!/bin/bash

. /opt/gearman-init/gearman-defaults.sh

# Get a Bash array containing a list of all the job names.
if [ -z ${GEARMAN_FUNCTIONS:+set} ]; then
  declare -a GEARMAN_FUNCTIONS
  # XXX: STDOUT from Drush commands using @sites comes with an unfortunate
  # amount of unfriendly baggage; better to loop manually.
  for site in $SITE_URI_LIST; do
    GEARMAN_FUNCTIONS=$CUSTOM_WORKER_FUCTIONS
    DRUSH_RETURN=$?
    if [ $DRUSH_RETURN -ne 0 ]; then
      logger "Could not determine worker functions."
      exit 1
    fi
  done
fi

exec $GEARMAN_BIN -v -h $GEARMAN_HOST -p $GEARMAN_PORT -w $GEARMAN_FUNCTIONS -- $ROUTER
