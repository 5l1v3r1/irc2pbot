#!/usr/bin/perl -w

use strict;
#use warnings;


use irc qw(:DEFAULT);
use web qw(:DEFAULT);
#use mysql qw(:DEFAULT);
use base qw(Bot::BasicBot);

# Add second nick later for if nick is reserved
# add password to authenticate nick 
# Make nice data structure to keep this data in perhaps a hash called bot
# Need to add method for if nick is in use what todo.
# Also need to be able to handle random disconnects and connect again and
# authenticate for nick to nickserv again
# Add method to check if tor is running?
 

# Create an instance of the bot and start it running. Connect
# to the main perl IRC server, and join some channels.
my $bot = Bot::BasicBot->new(

    server => "127.0.0.1",
    port   => "6668",
    channels => ["#testbot"],

    nick      => "whocareswhowho",
    alt_nicks => ["whowhowhowhowwhowhowhow", "DrWhooWhooWhoo"],
    username  => "whocareswhowho",
    name      => "whocareswhowho",

   

  );



#This is the main method that you'll want to override in your subclass 
#it's the one called by default whenever someone says anything that we can hear, either in a 
#public channel or to us in private that we shouldn't ignore.
sub said {
my $self = shift;
my $message = shift;
my $input = $message->{body};
my $channel = $message->{channel};



my ($how_many_found,$url) = checkForURL($input);
if ($how_many_found > 0) {
	# Okay we got a URL
	# Now add it to database.
#	my $dbh = connectToMySQL;
#	addURLToDB($dbh,$url,$channel);
#	disConnectMySQL($dbh);


	# Is it an eepsite? If yes do something else get title over tor
	# which assumes that site is either .onion or clearnet site.
my ($how_many_eep,$title) = isEepSite($url);  # Will print title of eepsite
if ($how_many_eep) {
 $self->say($title);
}
elsif (!$how_many_eep) {  # If this is not an eepsite
#     print "This is not an eepsite";
my $title = getStuffOverTor($url);
#printTitle($socket,$channel,$title,$url);
# Replace with self->say
 
$self->say($title);
}


}
}
$bot->run();



# Bot can be shut down with:
#$bot->shutdown( $bot->quit_message() );
