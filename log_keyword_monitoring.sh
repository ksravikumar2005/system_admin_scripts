#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 13/04/2017
# Description: Script for monitoring keywords in websphere logs - SystemOut / SystemErr for RedHat / Ubuntu / CentOS Operating Systems
# Place your keywords here /tmp/error_list
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
##################
send_mail="no";
> /tmp/mail_body
WAS_INSTALL_ROOT=/opt/IBM/WebSphere/AppServer80/profiles

cd /mnt

for i in `cat  /tmp/error_list | grep -v \#`;
do
for j in `find $WAS_INSTALL_ROOT/*/logs/Sys* -iname *.log`; do echo "====================$j=================";  grep  -a $i $j| tail -1; echo "" >>  /tmp/mail_body; done >> /tmp/mail_body
for j in `find $WAS_INSTALL_ROOT/*/logs/Sys* -iname *.log`; do grep  -a $i $j| tail -1 | grep -vE "'0 thread'|'1 thread'|'2 thread'"; done > /tmp/mail
if [ -s "/tmp/mail" ];then
cat /tmp/mail_body | mail -s  "$(echo -e "Errors `date` ")" email.address@email.com
fi
done;
