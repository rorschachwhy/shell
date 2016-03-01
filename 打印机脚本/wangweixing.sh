#!/bin/sh

HOSTNAME=(
"t101=58.68.148.50"

"t201=58.68.233.90"

"t301=123.56.16.9"

"t401=58.68.148.59"

"t501=58.68.224.154"

"t601=58.68.148.57"
)
environment=("t1"  "t2"  "t3"  "t4"  "t5"  "t6")

PORT="3306"
USERNAME="root"
PASSWORD="p@swrd123"
echo "
===================================使用说明=============================
 1、首次使用需要将每个环境的打印机表中ID为1的数据配置为可用的点点宝打印机，
 将ID为2的数据配置为可用的新观天打印机，并且绑定好店铺；
 2、本工具极度依赖打印机表ID为1和2两条数据，如果打印机表ID为1和2的数据
 发生改变，此工具可能会失效；
 3、记得清除缓存哦~
=========================================================================
"

echo "请输入需要配置打印机的环境代号，如t1:"

read keyboard
echo $keyboard

until [[ "${environment[@]/$keyboard}" != "${environment[@]}" ]]
do
   echo "您的输入有误，请重新输入"
   read keyboard
   echo $keyboard
done

open_sql="
update platform.t_core_gprs_printer
set  serial_number = '33e736f1d3be' where id= 1;

update platform.t_core_gprs_printer
set  serial_number = '118495086'    where id = 2 ;
"
close_sql="
update platform.t_core_gprs_printer
set  
serial_number = uuid() 
where serial_number = '33e736f1d3be'
or    serial_number = '118495086';
"
select_sql="
select  id,serial_number,is_online
from
platform.t_core_gprs_printer
where
serial_number = '33e736f1d3be'
or
serial_number = '118495086'
"
host1="${HOSTNAME[0]}"
host2="${HOSTNAME[1]}"
host3="${HOSTNAME[2]}"
host4="${HOSTNAME[3]}"
host5="${HOSTNAME[4]}"
host6="${HOSTNAME[5]}"

#查询打印机在哪个环境
for host in ${HOSTNAME[@]}
do  
    echo "$host"
    mysql -u$USERNAME -p$PASSWORD -h${host:5} -P$PORT -e "$select_sql" 
done

#关闭6套环境
for host in ${HOSTNAME[@]}
do  
    mysql -u$USERNAME -p$PASSWORD -h${host:5} -P$PORT -e "$close_sql" 
done

#打开1套环境
case $keyboard in
    
	 t1) mysql -u$USERNAME -p$PASSWORD -h${host1:5} -P$PORT -e "$open_sql" ;;
	 t2) mysql -u$USERNAME -p$PASSWORD -h${host2:5} -P$PORT -e "$open_sql" ;;
	 t3) mysql -u$USERNAME -p$PASSWORD -h${host3:5} -P$PORT -e "$open_sql" ;;
	 t4) mysql -u$USERNAME -p$PASSWORD -h${host4:5} -P$PORT -e "$open_sql" ;;
	 t5) mysql -u$USERNAME -p$PASSWORD -h${host5:5} -P$PORT -e "$open_sql" ;;
	 t6) mysql -u$USERNAME -p$PASSWORD -h${host6:5} -P$PORT -e "$open_sql" ;;

	esac	 
  
  
read -p "打印机已配置到环境$keyboard,请按任意键退出" var
  
  
  
  
  
  
  

