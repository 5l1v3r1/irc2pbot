#!/usr/bin/env perl
#===============================================================================
#
#         FILE: web.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 04/07/2014 08:23:26 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

#use Test::More tests => 1;                      # last test to print
use Test::More qw(no_plan);

BEGIN {
	use_ok("web");


}

require_ok("web");
my $r_url = "http://example.com/";

#is(my ($how_many,$url) = checkForURL("http://example.com"),$r_url, "Should find url : $r_url");
 my ($how_many,$url) = checkForURL("http://example.com"); 
 is($url,$r_url, "$url should be equal to $r_url");

 my $true = 1;
 my ($how_many_eep, $title) = isEepSite("http://tracker2.postman.i2p");
 is($how_many_eep, $true, "$how_many_eep should be equal to $true");

 # Still need to figure out how to check if tor is running and if
 # it is not runnning then start it.
 #
 #Mehods that need testing: getStuffOverTor, getStuffOverI2P
 #
