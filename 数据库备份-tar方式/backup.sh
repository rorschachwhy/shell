#!/bin/sh

#tar方式备份数据库

DATE=`date +_%Y_%m_%d_%H_%M_%S`

#数据库文件目录
path="/home/"

service mysqld stop

cd $path

tar cf mysql$DATE.tar mysql

service mysqld start
