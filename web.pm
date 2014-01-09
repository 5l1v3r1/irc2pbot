package web;    

use strict;
use warnings;


use URI::Find;
use URI::Find::Simple qw(list_uris);
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
        our @EXPORT = qw(getStuffOverTor checkForURL getStuffOverI2P isEepSite);

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
# Might need more work here later.
# my $title = getStuffOverI2P($url);
sub getStuffOverI2P {
my $url = $_[0];
my $mech = WWW::Mechanize->new(timeout => 60*8);
$mech->proxy(['http'],'http://localhost:4444');
# Only want http data to go over port 4444
# Set longer timeout perhaps for I2P eepsites.
# $mech->proxy(['https', 'http', 'ftp'], 'my_proxy:8080');
# Takes arguments in square brackets.
eval {

	$mech->get($url);
};

if ($@) {
return "Problem getting title.\n";
}
else 
{
# I could probably also just do
# Should probably put an eval around return $mech->title(); too
return $mech->title();
# Can't decide now but putting an eval here could also be a good idea.
# eval { $mech->get($url); }; if ($@) { return "Could not get title";}
 }
}

# Probably need a seperate getStuffOverI2PHTTPS
# http://localhost:4445



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
my $title;

my $is_eepsite = ($url =~ /\.(i2p.?)\b/i); # Put this in method later
if ($is_eepsite) {
	#   eval {
	$title = &getStuffOverI2P($url);
#};
#if ($@) {
 $title = "Could not get title, error occured.";
#}
	return (1,$title);
	# Call some method to get title of eepsite.
}
else {
	return (0,'');


}
}
# End of isEepSite sub
# Still need to write method to find the eepsite's title.




# This is how we end a module/external sub
-1
