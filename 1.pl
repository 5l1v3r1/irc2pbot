#!/usr/bin/perl -w

use strict;
#use warnings;


use irc qw(:DEFAULT);
use web qw(:DEFAULT);

# This setup works with I2p but for some reason only if I have my irc client open and connected to irc2p
my $nick = "blahblahblajh2";
my $login ="blahblahblajh2";
my $channel = "#testbot";

# Add second nick later for if nick is reserved
# add password to authenticate nick 
# Make nice data structure to keep this data in perhaps a hash called bot
# Need to add method for if nick is in use what todo.
# Also need to be able to handle random disconnects and connect again and
# authenticate for nick to nickserv again
# Add method to check if tor is running?
 




my $socket = createSocket;

setNick($socket,$login,$nick);

connectCheckNick($socket);

joinChan($socket,$channel);

# Keep reading the lines from the server respond to ping with pong
while (my $input = <$socket>) {
	chop $input;
	if ($input =~ /^PING(.*)$/i) {
		#Respond to ping
		print $socket "PONG $1\r\n";
	}
	# Everything happens here.
else { 
# Do something
#
my ($how_many_found,$url) = checkForURL($input);
if ($how_many_found > 0) {
	# Code that interacts with database. Make it add url to table here.


	# Okay we got a URL
	# Is it an eepsite? If yes do something else get title over tor
	# which assumes that site is either .onion or clearnet site.
my ($how_many_eep,$title) = isEepSite($url);  # Will print title of eepsite
 if (!$how_many_eep) {  # If this is not an eepsite
#     print "This is not an eepsite";
my $title = getStuffOverTor($url);
printTitle($socket,$channel,$title,$url);

} 

}


}
}

	


