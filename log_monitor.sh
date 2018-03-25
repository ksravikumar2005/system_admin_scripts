#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 02/02/2016
# Description: Script for monitoring log files for updates for RedHat / Ubuntu / CentOS Operating Systems
# Place all your files with complete paths at /tmp/file_list 

echo " "> /tmp/mail_body1;
echo "<table border="1">" >> /tmp/mail_body1;
for i in `cat  /tmp/file_list  | grep -v \#`;
do
a=`tail -1 $i | awk '{print $2" "$3}'`;
b=`tail -1 $i | awk '{print $1}'`;
j=`echo $i | cut -f3,6 -d/`
echo "<tr>" >> /tmp/mail_body1;
echo "<td> $j </td> <td> $b </td> <td> $a </td>">> /tmp/mail_body1;
echo "</tr>" >> /tmp/mail_body1;
done;
echo "</table>" >> /tmp/mail_body1;
d=`date`
cat /tmp/mail_body1| /usr/sbin/sendmail -s "$(echo -e "Log Status $d \nContent-Type: text/html")"   email.address@email.com
