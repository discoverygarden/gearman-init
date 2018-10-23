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
| `ROUTER` | The Drush command `islandora-job-router`, as user 1 and at `DRUPAL_ROOT`. | The routing command workers should send the Gearman payload to for processing. |
| `SITE_URI_LIST` | The "Site URI" portion of each entry in `drush @sites status` | A space-separated list of sites to get worker functions for. |
| `CUSTOM_WORKER_FUCTIONS` | String of functions for a custom worker | formated as such: "-f function1 -f function2". Defaults to "-f default"   |

## Custom Worker

This is currently on compatible with upstart

Copy `upstart/gearman-custom-worker.conf` files into `/etc/init`.

Add your custom working functions to `/etc/default/gearman-workers` in the following format:
```
CUSTOM_WORKER_FUCTIONS="-f function1 -f function2 -f function3"
```

Ensure total number of workers does not exceed total number of CPU cores. May have to configure the `CPU_COUNT` var as well.

stop gearman-workers
start gearman-workers

Your Custom worker should start with all the others.

## upstart

Copy the `upstart/gearman-workers.conf` and `upstart/gearman-worker.conf` files into `/etc/init`.

The workers should start and stop automatically at boot/shutdown (currently following/preceding `mysql` of startup/shutdown; may be desirable to make into configuration at some point?).

To start the workers immediately:
```bash
start gearman-workers
```

## sysvinit

Copy the `sysvinit/gearman-workers` and `sysvinit/gearman-worker` files into `/etc/init.d`.

Ensure permissions are 755

To have the gearman workers start on system boot, run the following:
```bash
# UBUNTU:
/usr/sbin/update-rc.d gearman-workers defaults 99 20
# REDHAT:
chkconfig --add gearman-workers
```

To start the workers immediately:
```bash
/etc/init.d/gearman-workers start
```
## systemd

Copy `systemd/*` files into /etc/systemd/system you may have to modify the `After=` in `gearmand.service` depending on how split out the stack is. 

### Enable on boot
where `n` is the total number of `Requires=` added to the `gearman-workers.target`

```
systemctl enable gearman-worker@{1..n}.service
```

### Status/start/stop
```
systemctl status gearman-workers.target
systemctl start gearman-workers.target
systemctl stop gearman-workers.target
```

Most options in the /etc/default/gearman-workers file has to be set, specially the path to binary ones as these are not available to the system at boot time.

## Note

There is a bug in gearman that may cause issue if the listening host/IP doesn't match the worker connection host/IP, ensure these are the same. 

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

[GPLv3](http://www.gnu.org/licenses/gpl-3.0.txt)
