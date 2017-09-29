<?php

/**
 * Small script to pull the Drupal sitelist so gearman-init can parse it.
 *
 * @param string $drupal_root
 *   The Drupal root directory (contains sites/sites.php).
 * @param string $ifs
 *   The separator to use for implosion.
 *
 * @return string
 *   An imploded list of sites.
 */
function gearman_init_get_sites($drupal_root = '/var/www/drupal7', $ifs = ' ') {
  require_once rtrim($drupal_root, '/') . '/sites/sites.php';
  print_r(implode($ifs, $sites));
}

?>
