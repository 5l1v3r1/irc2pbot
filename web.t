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
