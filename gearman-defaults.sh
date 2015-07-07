#!/bin/bash
DRUPAL_ROOT=${DRUPAL_ROOT:-/var/www/drupal7} 
DRUSH=${DRUSH:-/usr/bin/drush}
CPU_COUNT=${CPU_COUNT:-`find /sys/devices/system/cpu -maxdepth 1 -type d -regex '.*/cpu[0-9]+$' | wc -l`}
cd $DRUPAL_ROOT
GEARMAN_HOST=${GEARMAN_HOST:-`$DRUSH variable-get islandora_job_server_host --exact 2> /dev/null || echo -n 'localhost'`}
GEARMAN_PORT=${GEARMAN_PORT:-`$DRUSH variable-get islandora_job_server_port --exact 2> /dev/null || echo -n '4730'`}
GEARMAN_BIN=${GEARMAN_BIN:-`which gearman`}
