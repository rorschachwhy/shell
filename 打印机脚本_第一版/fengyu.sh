#!/bin/sh

HOSTNAME=(
"t101=58.68.148.50"
"t201=58.68.233.90"

)
PORT="3306"
USERNAME="root"
PASSWORD="XXXX"
echo "
===================================使用说明=============================
1.输入环境+空格+打印机号+空格+打印机号（需要输入两个打印机号）
2.环境只能t1~t6如果错误，将没有正确的打印机
3.然后会搜索各数据库，查询并显示出有正确的打印机
4.修改不需要环境的打印机串号
5.修改后就可以正常使用。
=========================================================================
"
echo "请输入要配置的打印机串号，并以空格分开" 
read env sen1 sen2
echo $env $sen1 $sen2

while [ ! -n "$sen1" ] || [ ! -n "$sen2" ]
do 
	echo "没有输入打印机串号，请重新输入"
	read env sen1 sen2
	echo $env $sen1  $sen2
done

search1_sql="SELECT 
    id,store_id,serial_number
FROM
    platform.t_core_gprs_printer
WHERE
    (\`serial_number\` = '${sen1}')
	
"
		
setClose1_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    \`serial_number\` = '666666'
WHERE
    \`serial_number\` = '${sen1}'
"  

setOpen1_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    \`serial_number\` = '${sen1}'
WHERE
    \`id\` = '1'
"	
search2_sql="
SELECT 
    id,store_id,serial_number
FROM
    platform.t_core_gprs_printer
WHERE
    (\`serial_number\` = '${sen2}')
"
setClose2_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    \`serial_number\` = '666666'
WHERE
    \`id\` ='${sen2}'
"

setOpen2_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    \`serial_number\` = '${sen2}'
WHERE
    \`id\` = '2'
"
for hostname in ${HOSTNAME[@]}
	do
		echo "$hostname"
		echo ${hostname:0:2}	
		if [[ ${hostname:0:2} != $env ]];then
			search_sql=$search1_sql
			search1_sql=$search2_sql
			setUnknown1_sql=$setClose1_sql
			setUnknown_sql=$setClose2_sql			
		else
			search_sql=$search1_sql
			search1_sql=$search2_sql
			setUnknown1_sql=$setOpen1_sql
			setUnknown_sql=$setOpen2_sql
		fi
		mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search_sql" 
		mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search1_sql"
		mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setUnknown1_sql"
		mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setUnknown_sql"
		
	done	

read -p "Press any key to continue." var


