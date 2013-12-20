package web;

use strict;
use warnings;


use URI::Find;
use URI::Find::Simple qw(list_uris);
use URI::Title qw(title);
use WWW::Mechanize;
use LWP::Protocol::socks;

# http://perldoc.perl.org/perlmod.html#Perl-Modules
BEGIN {
   require Exporter;

        # Set the version for version checking
        our $VERSION = 1.00;
        
        # Inherit from Exporter to export functions and variables.
        our @ISA = qw(Exporter);

        # Functions and variables which are exported by default.
        our @EXPORT = qw(getStuffOverTor checkForURL getStuffOverI2P);

        # Functions and variables which can be optionally exported
        #our @EXPORT_OK = qw($server %hashit func3); # Fill in my own here.
}
# Exported package globals go here

# Need to create function to check if tor is running?
# If Tor isn't running then start it.
# Call funtion with:
# my $title = getStuffOverTor($url);
#
sub getStuffOverTor {
my $url = $_[0];
my $mech = WWW::Mechanize->new(timeout => 60*5);
$mech->proxy(['http','https'],'socks://localhost:9050');
$mech->get($url);
return $mech->title();
# Up to about here.
} 

# my $title = getStuffOverI2P($url);
sub getStuffOverI2P {
my $url = $_[0];
my $mech = WWW::Mechanize->new(timeout => 60*5);
$mech->proxy(['http','https'],'http://localhost:4444');
$mech->get($url);
# I could probably also just do
return $mech->title();

}



# How to call:
# my ($how_many_found,$url) = checkForURL($input);
# if ($how_many_found > 0) {
# check If we have an eepsite
# else just get the title over tor
#
sub checkForURL {          
# Put this in a sub later
my @list = list_uris(@_);
my $how_many_found = @list;
# If this is an .i2p address use method  localhost:4444
# else use tor socks proxy 
# both .onion and normal urls are going to be fetched using tor.
# So no need to check if a url is an .onion url
my $url = $list[0];

return ($how_many_found,$url);

}


# Also return $how_many_eep 
# $how_many_found eep either always be 0 or 1.
# $how_many_found will return how many eepsites found in url.
# my ($how_many_eep, $title) = isEepSite($url);
# if ($how_many_eep ~= "0")
#
sub isEepSite {

my $url = $_[0];

my $is_eepsite = ($url =~ /\.(i2p.?)\b/i); # Put this in method later
if ($is_eepsite) {
	my $title = &getStuffOverI2P($url);
	return ("1",$title);
	# Call some method to get title of eepsite.
}
else {
	return ("0","Nothing found.");


}
}
# End of isEepSite sub
# Still need to write method to find the eepsite's title.




# This is how we end a module/external sub
-1
