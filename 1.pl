#!/usr/bin/perl -w

use strict;
#use warnings;


use IO::Socket;
use URI::Find;
use URI::Find::Simple qw(list_uris);
use URI::Title qw(title);
use WWW::Mechanize;
use LWP::Protocol::socks;

# This setup works with I2p but for some reason only if I have my irc client open and connected to irc2p
my $nick = "aaajajaaaaahhaaaa";
my $login ="aaaaaaaaaa";
my $channel = "#testbot";


# Add second nick later for if nick is reserved
# add password to authenticate nick 
# Make nice data structure to keep this data in perhaps a hash called bot

# Need to add method for if nick is in use what todo.
# Also need to be able to handle random disconnects and connect again and
# authenticate for nick to nickserv again
#
# Add method to check if tor is running?
#
 



sub getStuffOverTor {
my $url = $_[0];
my $mech = WWW::Mechanize->new(timeout => 60*5);
$mech->proxy(['http','https'],'socks://localhost:9050');
$mech->get($url);
my $title = $mech->title();
# Up to about here.
return $title;
} 

sub checkForURL {          
# Put this in a sub later
my @list = list_uris(@_);
my $how_many_found = @list;
# If this is an .i2p address use method  localhost:4444
# else use tor socks proxy 
# both .onion and normal urls are going to be fetched using tor.
# So no need to check if a url is an .onion url
if ($how_many_found > 0) {

# Put this shit in a method too!
#my $title = title($list[0]);
my $url = $list[0];
# End of function
# Return $how_many_found
# and return $url
# return ($how_many_found,$url);
#
# later in code
# if ($how_many_found > 0) {
# 

my $is_eepsite = ($url =~ /\.(i2p.?)\b/i); # Put this in method later
if ($is_eepsite) {
	print "We have an eepsite: $url\n";
	# Call some method to get title of eepsite.
}
else {
my $title = getStuffOverTor($url);

# Is this an eepsite. If it is do something,else just use socks connection
# to tor on localhost and we assume it is a regular website or .onion


# If the refactoring of this code works. Then make this sub return
# the url and the title and put these print statements in seperate sub.
print $socket "PRIVMSG $channel $url\n";
print $socket "PRIVMSG $channel Title: $title\n";
}	  
}		
}
# Should I prefix function being called with ampersand if it is being called from module?
my $socket = &createSocket;

&setNick;

&connectCheckNick;

&joinChan($socket,$channel);

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
&checkForURL($input);
	}
}

