
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
PASSWORD="p@swrd123"


search1_sql="SELECT 
    *
FROM
    platform.t_core_gprs_printer
WHERE
    (\`serial_number\` = '118495086'
        AND \`is_online\` = 'Y')"
		
setClose1_sql="
UPDATE platform.t_core_gprs_printer 
SET 
    \`serial_number\` = '666666'
WHERE
    \`serial_number\` = '118495086';"

setOpen1_sql="
UPDATE 
platform.t_core_gprs_printer 
SET 
    \`serial_number\` = '118495086'
WHERE
    \`id\` = '1'"

echo "请输入要配置的环境和打印机的值:" 
read env sess
echo $env $sess

while [ ! -n "$sess" ]
do 
	echo "输入参数缺失，请重新输入"
	read env sess
	echo $env $sess
done

		
for hostname in ${HOSTNAME[@]}
	do
		echo "$hostname"
		echo ${hostname:0:2}
		
		if [ ${hostname:0:2} != $env ];then
				search_sql=$search1_sql
				setClose_sql=$setClose1_sql
			else
				search_sql=$search1_sql
				setOpen_sql=$setOpen1_sql
		fi
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search_sql" 
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setClose_sql" 
		    mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setOpen_sql" 
		
		
	done

read -p "Press any key to continue." var






