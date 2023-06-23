# Raspberry Pi Docker Image for Open Source CPAP Analysis Reporter (OSCAR)

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/desertblade/oscar-pi)](https://hub.docker.com/r/desertblade/oscar-pi/tags)
[![license](https://img.shields.io/github/license/desertblade/oscar-pi)](https://github.com/desertblade/oscar-pi/blob/main/LICENSE)
[![DockerHub pulls](https://img.shields.io/docker/pulls/desertblade/oscar-pi.svg)](https://hub.docker.com/r/desertblade/oscar-pi/)
[![DockerHub stars](https://img.shields.io/docker/stars/desertblade/oscar-pi.svg)](https://hub.docker.com/r/desertblade/oscar-pi/)
[![GitHub stars](https://img.shields.io/github/stars/desertblade/oscar-pi.svg)](https://github.com/desertblade/oscar-pi)
[![Contributors](https://img.shields.io/github/contributors/desertblade/oscar-pi.svg)](https://github.com/desertblade/oscar-pi/graphs/contributors)

[![Docker Image CI](https://github.com/desertblade/docker-oscar-pi/actions/workflows/docker-image.yml/badge.svg)](https://github.com/desertblade/docker-oscar-pi/actions/workflows/docker-image.yml)

A Raspberry Pi Docker image for **[OSCAR](https://www.sleepfiles.com/OSCAR/)** to run inside Docker container and access it remotely using web browser. Includes script to pull data from an ezShare wifi card, so no need to pull the SD Card out of the CPAP machine!

Cron job is set to run every 30 minutes from 6-9 am to pull files from an [ezShare](https://www.aliexpress.us/item/2255800453813062.html) wifi SD card adpater.

Repository name in Docker Hub: **[desertblade/oscar-pi](https://hub.docker.com/r/desertblade/oscar-pi/)**  
Published via **automated build** mechanism  

![img.png](https://raw.githubusercontent.com/desertblade/oscar-pi/main/.github/demo-img.png)

## Pre-reqs

Raspberry Pi with OS Lite installed. Tested with Raspberry Pi 4GB.

[ezShare](https://www.aliexpress.us/item/2255800453813062.html) wifi SD adapter and an SD card, be sure to chose the combo for around $24! Configured and installed in your CPAP machine

USB wifi adapter. I find it easier to use dual wifi and you can get a decent adapter for under $10. Will add some recomendations later.

### Configure Dual Wifi
Assuming you are all set with you primary wifi network here is how I configured my wifi.

Move existing configuration over:
```
mv /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf 
```

Create wlan1 wifi configuration (I copy over wlan0 as a starting point)
```
cp /etc/wpa_supplicant/wpa_supplicant-wlan0.conf /etc/wpa_supplicant/wpa_supplicant-wlan1.conf 
```

Edit the file:
```
nano /etc/wpa_supplicant/wpa_supplicant-wlan1.conf 
```


Change Network info to you ezshare:
```
network={
    ssid="ezShareSSD"
    psk="my_password_in_plaintext"
}
```

Reboot Pi (sudo reboot). When its back up you should be able to SSH in and ping 192.168.4.1 which is the ezShare card.

### Install Docker
I find the version of Docker included in Rasbpberry Pi's repos are fine. 

From the command line run the following commands:
```
sudo apt update
sudo apt install docker-compose
```

## Docker Run
To simply do a quick and dirty run of the Oscar container:
```
docker run \
    -d --rm \
    --name oscar \
    -v=/home/pi/oscar-data:/data:rw \
    -v=/home/pi/SDCARD:/SDCARD:rw \
    --publish=8080:8080 \
     desertblade/oscar-pi
  
```
To stop the container simply run:
```
$ docker stop oscar
```
To remove the container simply run:
```
$ docker rm oscar
```

## Docker Compose
If you don't want to type out these long **Docker** commands, you could
optionally use [docker-compose](https://docs.docker.com/compose/) to set up your
image. Just download the repo and run it like so:

```yaml
version: '3.3'
services:
  oscar:
    image: desertblade/oscar-pi
    container_name: oscar
    restart: unless-stopped
    ports:
      - 8080:8080
    volumes:
      - /home/pi/oscar-data:/data:rw
      - /home/pi/SDCARD:/SDCARD:rw
```

## Issues
https://github.com/desertblade/oscar-pi/issues

## Contributers
The following people created 80%+ of the source. I just modified it to support Raspberry Pi with the script to copy files over.

Initial Dockerfile creation was done by [Roger Rumao ](https://github.com/rogerrum) --- https://github.com/rogerrum/docker-oscar
ezShare script created by [Biorn1950](https://github.com/Biorn1950) --- https://github.com/Biorn1950/EzShare-SdcardWifi-Downloader

## Software Licensing Information
------------------------------
DOCKER-OSCAR is released under the GNU GPL v3 License. Please see below for a note on giving correct attribution
in redistribution of derivatives.

It is built using Qt SDK (Open Source Edition), available from http://qt.io.

Redistribution of derivatives ( a note added by Mark Watins )
-----------------------------
Mark Watkins created this software to help lessen the exploitation of others. Seeing his work being used to exploit others
is incredibly un-motivational, and incredibly disrespectful of all the work he put into this project.

If you plan on reselling any derivatives of SleepyHead, I specifically request that you give due credit and
link back, mentioning clearly in your advertising material, software installer and about screens that your
derivative "is based on the free and open-source software SleepyHead available from http://sleepyhead.jedimark.net,
developed and copyright by Mark Watkins (C) 2011-2018."

It is not enough to reference that your derivative "is based on GPL software".
