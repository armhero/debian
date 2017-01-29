# Debian Linux

[![](https://images.microbadger.com/badges/image/armhero/debian.svg)](https://microbadger.com/images/armhero/debian "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/armhero/debian.svg)](https://microbadger.com/images/armhero/debian "Get your own version badge on microbadger.com")

A Debian Linux Docker base image for the ARM platform.

*Does only work on Raspberry 2 and above due lack of armv6 support.*

## Available tags

* **latest**: Latest stable image (e.g. jessie)
* **jessie**: Debian 8 "Jessie"

## CI/Auto-Builds

The image is automatically built by Jenkins CI on a Raspberry Pi Cluster. It will be rebuilt once a week (Bleeding Edge every night).
You can find the job definitions written in Jenkins DSL in the [armhero/jenkins-dsl](https://github.com/armhero/jenkins-dsl) repository.

### Manual Building

To build the image yourself, take a look in the `build.sh` script.

## More information

You can find more information and an overview over all images on [armhero.github.io](https://armhero.github.io).
