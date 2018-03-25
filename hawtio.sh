#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 14/11/2017
# Description: Script for running portainer as a service for RedHat / Ubuntu / CentOS Operating Systems
# Place this script with executable permissions in /etc/init.d folder.
# Replace the "hostname, hostname.domain" with appropriate values.
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
##################

SERVICE_NAME=hawtio-app-1.5.6
PATH_TO_JAR=/usr/local/hawtio-app-1.5.6.jar
PID_PATH_NAME=/tmp/hawtio-pid
case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            nohup /usr/local/jdk1.8.0_144/bin/java -jar -Dhawtio.authenticationEnabled=false -Dhawtio.proxyWhitelist="*, hostname, hostname.domain" /usr/local/hawtio-app-1.5.6.jar  >> /tmp/hawtio-app.out 2>&1&
            echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stoping ..."
            kill $PID;
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            nohup /usr/local/jdk1.8.0_144/bin/java -jar -Dhawtio.authenticationEnabled=false -Dhawtio.proxyWhitelist="*, hostname, hostname.domain" /usr/local/hawtio-app-1.5.6.jar  >> /tmp/hawtio-app.out 2>&1&
            echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac
