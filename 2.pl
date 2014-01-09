#!/usr/bin/perl -w
use strict;

use mysql qw(:DEFAULT);

my $url = "https://www.foo.com";
my $channel = "#whoogirls";

my $dbh = connectToMySQL;
addURLToDB($dbh,$url,$channel);
disConnectMySQL($dbh);



