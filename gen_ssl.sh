#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 02/02/2016
# Description: Script for checking HTTP Verb Tampering with different HTTP Verbs portainer as a service for RedHat / Ubuntu / CentOS Operating Systems
# Usage: ./http_verb_tampering.sh hostname # that has a service. Replace port as required.
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
usage : ./gen_ssl.sh <url / CN>
##################
openssl genrsa 2048 > $1.key
openssl req -new -x509 -nodes -sha1 -days 3650 -key $1.key -subj "/C=US/ST=SomeState/L=SomeCity/O=SomeOffice/CN=$1" > $1.cert
openssl x509 -noout -fingerprint -text < $1.cert > $1.info
cat $1.cert $1.key > $1.pem
chmod 400 $1.key $1.pem

