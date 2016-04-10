#!/bin/sh

#删除不再需要的数据库tar备份文件

#数据库文件目录
path="/home/"

if [[ "$1" =~ "tar" ]];then
	cd $path
	rm -rf $1
else 
	echo "not tar, should not delete"
fi
