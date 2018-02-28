
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
 1、首先请输入要配置打印机的环境
 （环境名形如t3，如果输入错误的环境号，将会把所有测试环境打印机都关闭）
 2、然后会搜索各数据库，打印出当前正确配置了打印机的数据库
 3、会更新所输入环境的打印机配置信息
 4、须清缓存以生效
=========================================================================
"
echo "请输入要配置打印机的环境:" 
read env
echo $env



search_sql="
SELECT 
    id,serial_number,type_id,store_id
FROM
    platform.t_core_gprs_printer
WHERE
    (id = '2' and serial_number = '118495086'
        AND type_id = '2')
        OR (id = '1' and serial_number = '33e736f1d3be'
        AND type_id = '1')
"
		
setClose_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    serial_number = '222222'
WHERE
    id = '2';
    
UPDATE platform.t_core_gprs_printer 
SET 
    serial_number = '111111' 
WHERE
    id = '1'
"		

setOpen_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    serial_number = '118495086' 
WHERE
    id = '2';
    
UPDATE platform.t_core_gprs_printer 
SET 
    serial_number = '33e736f1d3be'
WHERE
    id = '1'
"

		
for hostname in ${HOSTNAME[@]}
	do
		echo "$hostname"
		echo ${hostname:0:2}
		
		if [ ${hostname:0:2} != $env ];then
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search_sql" 
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setClose_sql"
			
			else
				
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search_sql" 
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setOpen_sql" 
		fi	
		
	done

read -p "Press any key to continue." var
