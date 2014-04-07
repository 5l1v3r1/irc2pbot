#!/usr/bin/perl -w
#
use strict;
use mysql;


 my $sql_instance = mysql->new(
	db => "urldatabase",
	user => "irc2pbot",
	pass => "jg&SH#2C.n=j9vHxzePMXAjeJ",
	host => "localhost",
); 

#my $hostname = $sql_instance->host();
#print "$hostname\n"

my $dbh = $sql_instance->connectToMySQL();
$sql_instance->addURLToDB($dbh,"http://www.google.com/foo","#testbot"); 
$sql_instance->disConnectMySQL($dbh);          
 
