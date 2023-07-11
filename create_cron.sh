#!/bin/bash

if [ ${CRON_HOUR} ]
  then
    echo ${CRON_HOUR} ${CRON_MIN} '* * * /opt/src/scripts/ezShareDownloader.sh 2>&1' >> /etc/cron.d/ezShare
    chmod 0644 /etc/cron.d/ezShare
    crontab /etc/cron.d/ezShare
    cron
fi 