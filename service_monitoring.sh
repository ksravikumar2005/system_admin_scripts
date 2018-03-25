#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 02/02/2016
# Description: Script for monitoring availability of http service or any service using nc for RedHat / Ubuntu / CentOS Operating Systems
# Please download nc for this script to work

for i in "place the list of hostnames / domain names here that exposes services here" ; do nc -z $i 80; nc -z $i 443; done