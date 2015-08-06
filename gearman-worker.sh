#!/bin/bash

. /opt/gearman-init/gearman-defaults.sh

# Get a Bash array containing a list of all the job names.
GEARMAN_FUNCTIONS=(${GEARMAN_FUNCTIONS[@]:-`$DRUSH --root=$DRUPAL_ROOT php-eval --format=string "return implode('$IFS', array_keys(module_invoke_all('islandora_job_register_jobs')));"`})

exec $GEARMAN_BIN -v -h $GEARMAN_HOST -p $GEARMAN_PORT -w ${GEARMAN_FUNCTIONS[@]/#/-f } -- $DRUSH --root=$DRUPAL_ROOT -u 1 islandora-job-router
