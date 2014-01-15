#!/usr/bin/perl -w

use strict;
#use warnings;


use web qw(:DEFAULT);
use mysql qw(:DEFAULT);

package irc2pbot;
#
use base qw(Bot::BasicBot);         
# Need to subclass Bot::BassicBot so that you can override said() routine

# Add second nick later for if nick is reserved
# add password to authenticate nick 
# Make nice data structure to keep this data in perhaps a hash called bot
# Need to add method for if nick is in use what todo.
# Also need to be able to handle random disconnects and connect again and
# authenticate for nick to nickserv again
# Add method to check if tor is running?
 
  sub said {
my ($self, $message) = @_;
my $input = $message->{body};
my $channel = $message->{channel};


my ($how_many_found,$url) = web::checkForURL($input);
if ($how_many_found > 0) {
	# Okay we got a URL
	# Now add it to database.
	my $dbh = mysql::connectToMySQL;
	mysql::addURLToDB($dbh,$url,$channel);   # Is it okay to connect and disconnect to database all
	mysql::disConnectMySQL($dbh);            # the time?


	# Is it an eepsite? If yes do something else get title over tor
	# which assumes that site is either .onion or clearnet site.
my ($how_many_eep,$title) = web::isEepSite($url);  # Will print title of eepsite
if ($how_many_eep) {
 return $title;
}
elsif (!$how_many_eep) {  # If this is not an eepsite
#     print "This is not an eepsite";
my $title = web::getStuffOverTor($url);
#printTitle($socket,$channel,$title,$url);
# Replace with self->say

return "$title\n";

}
}
}
# Create an instance of the bot and start it running. Connect
# to the main perl IRC server, and join some channels.
my $bot = irc2pbot->new(  # To use the said method that overrides Bot::BasicBot 
	                      # We create object of irc2pbot that will have the overrides said method
    server => "127.0.0.1",
    port   => "6668",
    channels => ["#testbot"],

    nick      => "whocareswhowho",
    alt_nicks => ["whowhowhowhowwhowhowhow", "DrWhooWhooWhoo"],
    username  => "whocareswhowho",
    name      => "whocareswhowho",

   

  );




$bot->run();

 
#This is the main method that you'll want to override in your subclass 
#it's the one called by default whenever someone says anything that we can hear, either in a 
#public channel or to us in private that we shouldn't ignore.


# Bot can be shut down with:
#$bot->shutdown( $bot->quit_message() );
