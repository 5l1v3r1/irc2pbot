#!/usr/bin/perl -w
 
 
 
my $db ="urldatabase";
my $user = "root";
 
## mysql database password
my $pass = "";
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";
 
## SQL query
my $channel = '#hello';
my $url = 'https://www.somwebsite.com';



  use strict;
  use DBI();

  # Connect to the database.
  my $dbh = DBI->connect("DBI:mysql:database=urldatabase;host=localhost",
                         "root", "jg&SH#2C.n=j9vHxzePMXAjeJ",
                         {'RaiseError' => 1});

  # INSERT some data into 'foo'. We are using $dbh->quote() for
  # quoting the name.
  $dbh->do("INSERT INTO urls(url,channel,date_posted)  VALUES ('$url','$channel',CURDATE());");

  # Same thing, but using placeholders

  # Now retrieve data from the table.
#  my $sth = $dbh->prepare("SELECT * FROM urls");
#  $sth->execute();
  
#  $sth->finish();

  # Disconnect from the database.
  $dbh->disconnect();
