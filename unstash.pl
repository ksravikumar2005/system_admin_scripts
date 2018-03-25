#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 14/05/2016
# Description: Recover password from .sth file used by iKeyMan tool for opening the .kdb files
# Usage Example: perl unstash.pl key.sth # name of your .sth file
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
##################

use strict;

die "Usage: $0 <stash file>\n" if $#ARGV != 0;

my $file=$ARGV[0];
open(F,$file) || die "Can't open the .sth file:  $file: $!";

my $stash;
read F,$stash,1024;

my @unstash=map { $_^0xf5 } unpack("C*",$stash);

foreach my $c (@unstash) {
    last if $c eq 0;
    printf "%c",$c;
}
printf "\n";
