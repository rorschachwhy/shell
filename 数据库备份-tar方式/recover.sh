#!/bin/sh

#tar方式回复数据库

#数据库文件目录
path="/home/"

cd $path

if [ -f "$1" ];then
	service mysqld stop
	rm -rf mysql
	tar xf $1
	service mysqld start
else 
	echo "not exist $1"
fi
