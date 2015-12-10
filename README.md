# Upstart: Gearman Worker Scripts

## Introduction

Upstart scripts/configuration to start Gearman workers.

## Requirements

This module requires the following modules/libraries:

* [Islandora Job](https://github.com/discoverygarden/islandora_job)
* Gearman CLI Script (Ubuntu: "gearman" package)

## Installation

Clone/unzip into `/opt` such that we have:
* `/opt/gearman-init/gearman-defaults.sh` and
* `/opt/gearman-init/gearman-worker.sh`

Provide any configuration necessary in `/etc/default/gearman-workers`:

| Variable | Default | Description |
| -------- | ------- | ----------- |
| `DRUPAL_ROOT` | `/var/www/drupal7` | Path to Drupal's root installation directory, so we can call Drush in the correct context. |
| `DRUSH` | The result of `which drush`. | Path of the `drush` executable. |
| `CPU_COUNT` | The number of CPU cores present on the system. | Something of a misnomer? The number of worker processes to create. |
| `GEARMAN_HOST` | The configured value from the "default" Drupal site. | The host/IP of the Gearman server. |
| `GEARMAN_PORT` | The configured value from the "default" Drupal site. | The port to connect to on the Gearman server host. |
| `GEARMAN_BIN` | The result of `which gearman`. | Path of the `gearman` CLI executable. |
| `GEARMAN_USER` | `www-data` | The user as which to run Gearman workers. |

##UPSTART

Copy the `upstart/gearman-workers.conf` and `upstart/gearman-worker.conf` files into `/etc/init`.

The workers should start and stop automatically at boot/shutdown (currently following/preceding `mysql` of startup/shutdown; may be desirable to make into configuration at some point?).

To start the workers immediately:
```# start gearman-workers```

##SYSVINIT

Copy the `sysvinit/gearman-workers` and `sysvinit/gearman-worker` files into `/etc/init.d`.
Ensure permissions are 755


To have the gearman workers start on system boot, run the following:
/usr/sbin/update-rc.d gearman-workers defaults 99 20

To start the workers immediately:
```# /etc/init.d/gearman-workers start```

## Troubleshooting/Issues

Having problems or solved a problem? Contact [discoverygarden](http://support.discoverygarden.ca).

## Maintainers/Sponsors

Current maintainers:

* [discoverygarden Inc.](http://www.discoverygarden.ca)

## Development

If you would like to contribute to this module, please check out our helpful
[Documentation for Developers](https://github.com/Islandora/islandora/wiki#wiki-documentation-for-developers)
info, [Developers](http://islandora.ca/developers) section on Islandora.ca and
contact [discoverygarden](http://support.discoverygarden.ca).

## License

Contact discoverygarden if there are questions.
