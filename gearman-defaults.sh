#!/bin/bash

# Any of the values specified in this file can be overridden in
# /etc/default/gearman-workers, by defining them. Say we want to restrict
# to 2 cores, you could put: "CPU_COUNT=2" in /etc/default/gearman-workers.
# Something like: "echo CPU_COUNT=2 >> /etc/default/gearman-workers" would
# get it done.
[ -r /etc/default/gearman-workers ] && . /etc/default/gearman-workers

DRUPAL_ROOT=${DRUPAL_ROOT:-/var/www/drupal7}
DRUSH=${DRUSH:-`which drush`}
CPU_COUNT=${CPU_COUNT:-$(expr \( `find /sys/devices/system/cpu -maxdepth 1 -type d -regex '.*/cpu[0-9]+$' | wc -l` + 1 \) / 2)}
GEARMAN_HOST=${GEARMAN_HOST:-`$DRUSH --root=$DRUPAL_ROOT variable-get islandora_job_server_host --exact --format=string 2> /dev/null || echo -n 'localhost'`}
GEARMAN_PORT=${GEARMAN_PORT:-`$DRUSH --root=$DRUPAL_ROOT variable-get islandora_job_server_port --exact --format=string 2> /dev/null || echo -n '4730'`}
GEARMAN_BIN=${GEARMAN_BIN:-`which gearman`}
GEARMAN_USER=${GEARMAN_USER:-www-data}
# For multisites requiring per-site routing, a different router is provided
# at https://github.com/discoverygarden/gearman-multisite-job-router
ROUTER=${ROUTER:-"$DRUSH --root=$DRUPAL_ROOT -u 1 islandora-job-router"}
SITE_URI_LIST=${SITE_URI_LIST:-$(for i in `find -L $DRUPAL_ROOT -name settings.php`; do basename `dirname $i`; done)}
CUSTOM_WORKER_FUCTIONS=${CUSTOM_WORKER_FUCTIONS:-"-f default"}
