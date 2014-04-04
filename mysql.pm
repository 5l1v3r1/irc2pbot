package mysql;

use strict;
use DBI();
 
BEGIN {
	require Exporter;

	# Set version for version tracking.
	our $VERSION = 1.00;

	#Inherit from Exporter to export functions and variables.
	our @ISA = qw(Exporter);

	# Functions and variables which are exported by default.
	our @EXPORT = qw($db $user $pass $host connectToMySQL addURLToDB disConnectMySQL);
}

# Login and view entries:
#  mysql -u irc2pbot -p urldatabase
#
#  mysql> select * from urls;
#
# I can write a function to change these values but for now
# they will stay the same for development.
my $db ="urldatabase";
my $user = "irc2pbot";
 
## mysql database password
my $pass = "jg&SH#2C.n=j9vHxzePMXAjeJ";
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";
 


# To call:
# my $dbh = connectToMySQL($host,$database,$user,$password);
sub connectToMySQL {
  # Connect to the database.
  my $host = $_[0];
  my $db = $_[1];  
  my $user = $_[2];
  my $pass = $_[3];
  my $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
                         "$user","$pass" ,
                         {'RaiseError' => 1});
 return $dbh;
 }

 # To call 
 # addURLToDB($dbh,$url,$channel);
 # Changing code to be less vunerable to sql injection (I hope)
 # This method should probably return something ? Would like to see if it throws an error.
sub addURLToDB {
my $dbh = $_[0];
my $url = $_[1];
my $channel = $_[2];

# INSERT some data into 'foo'. We are using $dbh->quote() for
# quoting the name.
#$dbh->do("INSERT INTO urls(url,channel,date_posted) VALUES ('$url','$channel',NOW());");

my $sql_code = "INSERT INTO urls(url,channel,date_posted) VALUES (?,?,NOW());";
my $sth = $dbh->prepare($sql_code) or die $dbh->errstr;
$sth->execute($url,$channel) or die $sth->errstr;

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


# We need a method for retriving the entries and displaying them
# on some webpage: mysql> select * from urls;


# Think if I need sql injection protectin later on. If I do,
# look at sql query parameterization on rosetta code.

-1

