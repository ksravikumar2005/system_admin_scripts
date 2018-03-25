#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 02/02/2016
# Description: Script for checking HTTP Verb Tampering with different HTTP Verbs portainer as a service for RedHat / Ubuntu / CentOS Operating Systems
# Usage: ./http_verb_tampering.sh hostname # that has a service. Replace port as required.
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
##################

for webservmethod in GET POST PUT TRACE CONNECT OPTIONS PROPFIND;

do
printf "$webservmethod " ;
printf "$webservmethod / HTTP/1.1\nHost: $1\n\n" | nc -q 1 $1 80 | grep "HTTP/1.1"

done
