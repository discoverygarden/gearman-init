<?php

/**
 * @file
 * Script to grab the site URI list from sites.php
 *
 * Runs one time when the gearman-workers service is started.
 */

// Check the number of arguments.
if ($argc < 2) {
  error_log("Not enough arguments passed to gearman-init/php/site_uri_list.php; expecting at least 2, got $argc");
  exit(1);
}

// Ensure sites.php is a file that exists and is readable.
$drupal_root = $argv[1];
if (!is_readable("$drupal_root/sites/sites.php")) {
  error_log("Failed to find the Drupal sites.php at '$drupal_root/sites/sites.php' or it is not readable; can't get site_uri_list for gearman-init/php/site_uri_list.php");
  exit(1);
}

// Include sites.php; check that $sites exists.
include("$drupal_root/sites/sites.php");
if (!isset($sites) || !is_array($sites)) {
  error_log('Loaded Drupal sites.php, but the $sites variable doesn not exist or is not an array.');
  exit(1);
}

// Print unique entries in the sites list.
print_r(implode(' ', array_unique($sites)));

?>
