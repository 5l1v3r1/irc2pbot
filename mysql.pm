package mysql;

use strict;
use DBI();
use Moose;




# Login and view entries:
#  mysql -u irc2pbot -p urldatabase
#
#  mysql> select * from urls;
#
# I can write a function to change these values but for now
# they will stay the same for development.
has 'db' => (
is => 'ro', # Once this value has been set there is no reason to change it.
isa => 'Str', # Value is a string
required => 1,  # Attribute must be defined.
);

has 'user' => (
is => 'ro',
isa => 'Str',
required => 1,
);

has 'pass' => (
is => 'ro',
isa => 'Str',
required => 1,
);

has 'host' => (
is => 'ro'
isa => 'Str',
required => 1,
);
# Maybe rather make a hash to represent these values?
# Don't know how to do this.


# Use mysql;
# my $sql_instance = mysql->new(
# db => "urldatabase",
# user => "irc2pbot",
# pass => "somepassword",
# host => "localhost",
# );

# Calling methods:
# $sql_instance->connectToMySQL();

#my $db ="urldatabase";
#my $user = "irc2pbot";
 
## mysql database password
#my $pass = "jg&SH#2C.n=j9vHxzePMXAjeJ";
 
## user hostname : This should be "localhost" but it can be diffrent too
#my $host="localhost";
 


# To call:
# my $dbh = connectToMySQL();
sub connectToMySQL {
my $self = shift;

  # Connect to the database.
  my $dbh = DBI->connect("DBI:mysql:database=$self->db();host=$self->host()",
                         "$self->user()","$self->pass()" ,
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


1
