irc2pbot
========

Irc Bot for IRC2P in Perl


Need to add things in the readme. You need to install mysql-server

# apt-get install mysql-server

Set your root password to the same root password for mysql set in mysql.pm

You need to create database called: "urldatabase"
# Will add the command to do that here later.

You need to create table called: "urls".
# Will add the command to do that here later. 

I should try find a way to automate the installation of dependencies 
and creation of database and table.


MYSQL Notes:
-------------


mysql> create database urldatabase;

mysql> use urldatabase;

mysql> show databases;

This is nice: http://www.aboutlinux.info/2005/06/mysql-cheat-sheet.html

create table urls ( id INT AUTO_INCREMENT PRIMARY KEY,url varchar(80),channel varchar(80),date_posted datetime);
----------------------


-------------------------------
Create non root user for mysql database:

http://www.cyberciti.biz/faq/mysql-user-creation/

Login as root:
-----------
$ mysql -u root -p

mysql> CREATE DATABASE urldatabase;

Create user called "irc2pbot" for database "urldatabase":
---------------------------------------
mysql> GRANT ALL ON urldatabase.* TO irc2pbot@localhost IDENTIFIED BY 'jg&SH#2C.n=j9vHxzePMXAjeJ';

$ mysql -u irc2pbot -p urldatabase




See if everything works?
---------------------------


$ ./2.pl

$ mysql -u ircpbot -p urldatabase
 
mysql> select * from urls;
+----+---------------------+------------+---------------------+
| id | url                 | channel    | date_posted         |
+----+---------------------+------------+---------------------+
|  1 | https://www.foo.com | #whoogirls | 2014-01-07 08:59:28 |
+----+---------------------+------------+---------------------+
1 row in set (0.02 sec)

mysql> 

