
#!/bin/sh

HOSTNAME=(
"t101=58.68.148.50"
"t201=58.68.233.90"
"t301=123.56.16.9"
"t401=58.68.148.59"
"t501=58.68.224.154"
"t601=58.68.148.57"

)


PORT="3306"
USERNAME="root"
PASSWORD="XXXX"
echo "
===================================使用说明=============================
 1、首先请输入要配置打印机的环境和串号
 （环境名形如t3 ）
 2、然后会搜索各数据库，打印出当前配置打印机的数据库
 3、会更新所输入环境的打印机配置信息
 4、须重新清缓存以生效
=========================================================================
"
echo "请输入要配置的环境和两个串号:[ 测试常用串号：33e736f1d3be  118495086 ]" 
read env ser1 ser2
echo $env $ser1 $ser2

while [ ! -n "$ser1" ]
do 
	echo "输入参数缺失，请重新输入"
	read env ser1 ser2
	echo $env $ser1 $ser2
	done

searchd_sql="
SELECT 
    serial_number,is_online,store_id
FROM
    platform.t_core_gprs_printer
WHERE
    (\`serial_number\` = '${ser1}'
	
	
       )
        OR (\`serial_number\` = '${ser2}'
		
		
        )
"
		
setClosed_sql="
UPDATE platform.t_core_gprs_printer
SET 
    \`serial_number\` = '666666'
	
WHERE
   \`serial_number\` = '${ser1}';
  
UPDATE platform.t_core_gprs_printer
SET 
    \`serial_number\` = '888888'
WHERE
     \`serial_number\` = '${ser2}'
    
  
"		

setOpend_sql="
UPDATE platform.t_core_gprs_printer
SET 
    \`serial_number\` = '${ser1}'
	
WHERE
    \`id\` = '1';
  
UPDATE platform.t_core_gprs_printer
SET 
    \`serial_number\` = '${ser2}'
	
WHERE
    \`id\` = '2'
    
  
"


		
for hostname in ${HOSTNAME[@]}
	do
		echo $hostname
		echo ${hostname:0:2}
		
		if [ ${hostname:0:2} != $env ];then
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$searchd_sql" 
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setClosed_sql"
			else
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$searchd_sql"
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setOpend_sql" 
			fi
			
			
		
		
	done

read -p "Press any key to continue." var

#echo "${HOSTNAME[0]}"
#mysql -u$USERNAME -p$PASSWORD -h${HOSTNAME[0]:5:12} -P$PORT -e "$taobao1_sql"




