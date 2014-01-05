#!/usr/bin/perl -w

use strict;
use DBI();
 
# I can write a function to change these values but for now
# they will stay the same for development.
my $db ="urldatabase";
my $user = "root";
 
## mysql database password
my $pass = "jg&SH#2C.n=j9vHxzePMXAjeJ";
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";
 
## SQL query
my $channel = '#yossssu';
my $url = 'https://www.som.com/';


# To call:
# my $dbh = connectToMySQL();
sub connectToMySQL {
  # Connect to the database.
  my $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
                         "$user","$pass" ,
                         {'RaiseError' => 1});
 return $dbh;
 }


sub addURLToDB {
# INSERT some data into 'foo'. We are using $dbh->quote() for
# quoting the name.
$dbh->do("INSERT INTO urls(url,channel,date_posted)  VALUES ('$url','$channel',NOW());");

# NOW(); is a mysql function that returns current date and time
}

# Disconnect from the database.
# my $dbh = connectToMySQL();
# disConnectMySQL($dbh);
#
sub disConnectMySQL {
my $dbh = $_[0];
$dbh->disconnect();


}
