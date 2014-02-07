#!/usr/bin/perl 
#===============================================================================
#
#         FILE: dancr.pl
#
#        USAGE: ./dancr.pl  
#
#  DESCRIPTION: GGGG
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 01/21/2014 09:45:34 AM
#     REVISION: ---
#===============================================================================

#use strict;
#use warnings;
use utf8;
use Dancer;
use DBI;
use File::Spec;
use File::Slurp;
# Username is admin
# password is password.
#set 'database' => File::Spec->catfile(File::Spec->tmpdir(), 'dancr.db');
set 'session'      => 'Simple';
set 'template'     => 'template_toolkit';
set 'logger'       => 'console';
set 'log'          => 'debug';
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;
set 'username' => 'admin';
set 'password' => 'password';
set 'layout' => 'main';



#my $database ="urldatabase";
#my $user = "irc2pbot";
my $database ="blogdatabase";
my $user = "bloguser";
 
 # Login as root and created database blogdatabase
 # mysql -u root -p
 # mysql> create database blogdatabase;
 # mysql> GRANT ALL ON blogdatabase.* TO bloguser@localhost IDENTIFIED BY "helloworld13";
 # mysql> flush privileges;
 # $ mysql -u bloguser -p blogdatabase
 
## mysql database password
#my $pass = "jg&SH#2C.n=j9vHxzePMXAjeJ";
my $pass = "helloworld13";
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";


my $flash;

sub set_flash {
my $message = shift;
$flash = $message;
}

sub get_flash {
my $msg = $flash;
$flash = "";
}

# To call:
# my $dbh = connect_db();
sub connect_db {
  # Connect to the database.
  my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
                         "$user","$pass" ,
                         {'RaiseError' => 1});
 return $dbh;
 }


#sub connect_db {
#	my $dbh = DBI->connect("dbi:SQLite:dbname=".setting('database')) or 
#	die $DBI::errstr;

#	return $dbh;
#}

# View schema in mysql?

# I doubt we need this here.

#sub init_db {
#	my $db = connect_db();
#	my $schema = read_file('./schema.sql');
#	$db->do($schema) or die $db->errstr;
#}

# What I used to create table entries in mysql equivalent of what we had
# but for sqlite3:
# mysql> create table entries( id INT auto_increment primary key,title varchar(300) not null,text varchar(300) not null);
                    


hook before_template => sub {
my $tokens = shift;

$tokens->{'css_url'} = request->base . 'css/style';
$tokens->{'login_url'} = uri_for('/login');
$tokens->{'logout_url'} = uri_for('logout');
};



get '/' => sub {
	my $db = connect_db();
	my $sql = 'select id,title,text from entries order by id desc';
	my $sth = $db->prepare($sql) or die $db->errstr;
	$sth->execute or die $sth->errstr;
	template 'show_entries.tt' , {
		'msg' => get_flash(),
		'add_entry_url' => uri_for('/add'),
		'entries' => $sth->fetchall_hashref('id'),
	};
};


post '/add' => sub {
	if (not session('logged_in') ) {
		send_error("Not logged in",401);
	}

	my $db = connect_db();
	my $sql = 'insert into entries (title,text) values (?,?)';
	my $sth = $db->prepare($sql) or die $db->errstr;
	$sth->execute(params->{'title'},params->{'text'}) or die $sth->errstr;

	## Flash keyword imported by Dancer::Plugin::FlashMessage
	## Not part of dancer core
	set_flash("New Entry Posted!");

	redirect '/';

	};


#Login
any ['get', 'post'] => '/login' => sub {
     my $err;

     if ( request->method() eq "POST" ) {
       # process form input
       if ( params->{'username'} ne setting('username') ) {
         $err = "Invalid username";
       }
       elsif ( params->{'password'} ne setting('password') ) {
         $err = "Invalid password";
       }
       else {
         session 'logged_in' => true;
         set_flash('You are logged in.');
         return redirect '/';
       }
    }

    # display login form
    template 'login.tt', { 
      'err' => $err,
    };
  };

# Lougout
get '/logout' => sub {
     session->destroy;
     set_flash('You are logged out.');
     redirect '/';
  };


#init_db();
start;

	


	

