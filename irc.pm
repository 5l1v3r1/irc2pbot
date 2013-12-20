package irc;

use strict;
use warnings;

# http://perldoc.perl.org/perlmod.html#Perl-Modules
BEGIN {
   require Exporter;

	# Set the version for version checking
	our $VERSION = 1.00;
	
	# Inherit from Exporter to export functions and variables.
	our @ISA = qw(Exporter);

	# Functions and variables which are exported by default.
	our @EXPORT = qw(printTitle setNick connectCheckNick joinChan createSocket $server $port); 

	# Functions and variables which can be optionally exported
	#our @EXPORT_OK = qw($server %hashit func3); # Fill in my own here.
}
# Exported package globals go here

# This is always the same for IRC2P
#our $server = "127.0.0.1";
#our $port = "6668";
# I could leave it out and then people could change the values. But this
# is an irc bot for I2P,thus the values wont change. I can use keyword "my"
# and ensure that values are private
my $server = "127.0.0.1";
my $port = "6668";



# Usage:
#  my $socket = createSocket;
#  
sub createSocket {
my $socket = new IO::Socket::INET (
	PeerAddr => $server,
	PeerPort => $port,
	Proto => 'tcp'
) or die "Error in socket connection! Socket could be in use. $!\n";

return $socket

}




# Create sub to create socket. The sub returns $socket
# Call like so in main: 
# my $socket = &createSocket;
# &setNick($socket,$login,$nick);
# Pass it parameter $nick and $socket and $login
sub setNick {
my $socket = $_[0];
my $login = $_[1];
my $nick = $_[2];

print $socket "NICK $nick\r\n";
print $socket "USER $login 8 *:Sample IRC Bot In Perl\r\n";
} 

# Print title in channel
# Call by
# my $socket = createSocket;
# my $title = getStuffOverTor($url);
# printTitle($socket,$channel,$title,$url);
#
sub printTitle {
my $socket = $_[0];
my $channel = $_[1];
my $title = $_[2];
my $url = $_[3];

print $socket "PRIVMSG $channel $url\n";
print $socket "PRIVMSG $channel Title: $title\n";
}

# Call by
# my $socket = createSocket;
# connectCheckNick($socket);
#
sub connectCheckNick {
# According to this link:
# http://oreilly.com/pub/h/1964
# Read lines from server until it tells us we have connected
my $socket = $_[0];

while (my $input = <$socket>) {
	# Check numerical responses from the server
	if ($input =~ /004/) {
		# Means we are logged in
		last;
	}
	elsif ($input =~ /433/) {
		die "Nickname is in use";
		# // Later make it switch to second nickname
	}
}
}
#Call by 
# my $socket = createSocket;
# joinChan($socket,$channel);
sub joinChan {
my $socket = $_[0];
my $channel = $_[1];

# Now we can join a channel!
#   Write function to do this

print $socket "JOIN $channel\r\n";
 
}

 
-1
 








