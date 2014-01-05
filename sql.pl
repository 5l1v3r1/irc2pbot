#!/usr/bin/perl -w

# Todo:
# CURDATE should save time accurate to minute and seconds
# Use all variables.
 
 
my $db ="urldatabase";
my $user = "root";
 
## mysql database password
my $pass = "jg&SH#2C.n=j9vHxzePMXAjeJ";
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";
 
## SQL query
my $channel = '#yossssu';
my $url = 'https://www.som.com/';



  use strict;
  use DBI();

  # Connect to the database.
  my $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
                         "$user","$pass" ,
                         {'RaiseError' => 1});

  # INSERT some data into 'foo'. We are using $dbh->quote() for
  # quoting the name.
  $dbh->do("INSERT INTO urls(url,channel,date_posted)  VALUES ('$url','$channel',NOW());");

  # NOW(); is a mysql function that returns current date and time
  # Disconnect from the database.
  $dbh->disconnect();
