#!/bin/bash

# Any of the values specified in this file can be overridden in
# /etc/default/gearman-workers, by defining them. Say we want to restrict
# to 2 cores, you could put: "CPU_COUNT=2" in /etc/default/gearman-workers.
# Something like: "echo CPU_COUNT=2 >> /etc/default/gearman-workers" would
# get it done.
[ -r /etc/default/gearman-workers ] && . /etc/default/gearman-workers

DRUPAL_ROOT=${DRUPAL_ROOT:-/var/www/drupal7}
DRUSH=${DRUSH:-`which drush`}
CPU_COUNT=${CPU_COUNT:-`find /sys/devices/system/cpu -maxdepth 1 -type d -regex '.*/cpu[0-9]+$' | wc -l`}
GEARMAN_HOST=${GEARMAN_HOST:-`$DRUSH --root=$DRUPAL_ROOT variable-get islandora_job_server_host --exact --format=string 2> /dev/null || echo -n 'localhost'`}
GEARMAN_PORT=${GEARMAN_PORT:-`$DRUSH --root=$DRUPAL_ROOT variable-get islandora_job_server_port --exact --format=string 2> /dev/null || echo -n '4730'`}
GEARMAN_BIN=${GEARMAN_BIN:-`which gearman`}
GEARMAN_USER=${GEARMAN_USER:-www-data}
SITE_URI_LIST=${SITE_URI_LIST:-(http://localhost)}
