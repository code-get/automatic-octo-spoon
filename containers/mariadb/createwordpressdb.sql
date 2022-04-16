/*
-- mysql -h 127.0.0.1 -P 3306 -u root -p
mysql> SET @wpadminpass = 'changeme';
mysql> SET @wphostname  = 'mywordpresshostname';
mysql> \. createwordpressdb.sql
*/
CREATE DATABASE wordpressdb;
use wordpressdb;
GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wpadmin'@@wphostname IDENTIFIED BY @wpadminpass;

