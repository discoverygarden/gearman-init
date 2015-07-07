#!/bin/bash

. /opt/gearman-init/gearman-defaults.sh

GEARMAN_FUNCTIONS=(${GEARMAN_FUNCTIONS[@]:-`$DRUSH --root=$DRUPAL_ROOT php-eval --format=string "return implode('$IFS', array_keys(module_invoke_all('islandora_job_register_jobs')));"`})
cd $DRUPAL_ROOT
$GEARMAN_BIN -v -h $GEARMAN_HOST -p $GEARMAN_PORT -w ${GEARMAN_FUNCTIONS[@]/#/-f } $DRUSH -u 1 islandora-job-router
