---
layout: post
title: 'Media Wiki' 
author: haeyeon.hwang
tags: [wiki]
image: /assets/img/blog/fintech.png
hide_image: true
---

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## Media Wiki
### Installation

~~~bash
$ sudo apt update
$ sudo apt install apache2 mysql-server php php-mysql libapache2-mod-php php-xml php-mbstring
$ sudo apt install apache2 mysql-server php5 php5-mysql libapache2-mod-php5
$ sudo apt install php-apcu php-intl imagemagick inkscape php-gd php-cli php-curl git
$ sudo apt install mediawiki
~~~

### Databases

https://askubuntu.com/questions/766334/cant-login-as-mysql-user-root-from-normal-user-account-in-ubuntu-16-04

* First, connect in sudo mysql

~~~bash
$ sudo mysql -u root
~~~

* Check your accounts present in your db, Delete current root@localhost account

~~~console
mysql> SELECT User,Host FROM mysql.user;
+------------------+-----------+
| User             | Host      |
+------------------+-----------+
| admin            | localhost |
| debian-sys-maint | localhost |
| magento_user     | localhost |
| mysql.sys        | localhost |
| root             | localhost |

mysql> DROP USER 'root'@'localhost';
Query OK, 0 rows affected (0,00 sec)
Recreate your user

mysql> CREATE USER 'root'@'%' IDENTIFIED BY '';
Query OK, 0 rows affected (0,00 sec)
Give permissions to your user (don't forget to flush privileges)

mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
Query OK, 0 rows affected (0,00 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0,01 sec)
Exit MySQL and try to reconnect without sudo.
~~~

### References

* https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Debian_or_Ubuntu/ko#%EB%AF%B8%EB%94%94%EC%96%B4%EC%9C%84%ED%82%A4_%EC%84%A4%EC%B9%98
* https://studyforus.com/doda/239777
* https://www.mediawiki.org/wiki/Manual:FAQ/ko
* https://zetawiki.com/wiki/%EB%AF%B8%EB%94%94%EC%96%B4%EC%9C%84%ED%82%A4%EC%97%90_%EB%82%98%EB%88%94%EA%B3%A0%EB%94%95_%ED%8F%B0%ED%8A%B8_%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0