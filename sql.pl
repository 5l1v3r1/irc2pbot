#!/usr/bin/perl -w
 
use DBI;
use strict;
 
print "Content-type: text/html\n\n";
 
my $db ="urldatabase";
my $user = "root";
 
## mysql database password
my $pass = "jg&SH#2C.n=j9vHxzePMXAjeJ";
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";
 
## SQL query
my $channel = "#help";
my $url = "https://www.duckduckgo.com";


my $query = "insert into urls(url,channel,date_posted) value($url,$channel,CURDATE());";
 
my $dbh = DBI->connect("DBI:mysql:$db:$host", $user, $pass);
my $sqlQuery  = $dbh->prepare($query)
or die "Can't prepare $query: $dbh->errstr\n";
 
my $rv = $sqlQuery->execute
or die "can't execute the query: $sqlQuery->errstr";
 
}
 
my $rc = $sqlQuery->finish;
exit(0);
