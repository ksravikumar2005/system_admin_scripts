#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 12/10/2017
# Description: Script for running portainer as a service for RedHat / Ubuntu / CentOS Operating Systems
# Place this script with executable permissions in /etc/init.d folder.
# Download the Portainer jar from https://github.com/portainer/portainer/releases/download/1.10.2/portainer-1.10.2-linux-amd64.tar.gz
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
##################
 
SERVICE_NAME=portainer
INSTALL_PATH=/var/software/portainer
PATH_TO_EXE=/var/software/portainer/portainer
PID_PATH_NAME=/tmp/portainer
PORTAINER_PORT=9988
PORTAINER_LOG=/tmp
case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            nohup $PATH_TO_EXE -d $INSTALL_PATH -p :$PORTAINER_PORT >> $PORTAINER_LOG/portainer.out 2>&1&
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
esac
