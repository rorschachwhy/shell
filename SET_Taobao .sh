
#!/bin/sh

HOSTNAME=(
"t101=58.68.148.50"
"t102=58.68.148.51"
"t111=58.68.148.52"
"t112=58.68.148.53"

"t201=58.68.233.90"
"t202=58.68.233.91"
"t211=58.68.233.92"
"t212=58.68.233.93"

"t301=123.56.16.9"
"t302=123.56.16.14"
"t311=123.56.16.19"
"t312=123.56.16.24"

"t401=58.68.148.59"
"t402=58.68.148.60"
"t411=58.68.148.61"

"t501=58.68.224.154"
"t502=58.68.224.155"
"t511=58.68.224.156"

"t601=58.68.148.57"
"t602=58.68.148.58"
"t611=58.68.233.94"
)


PORT="3306"
USERNAME="root"
PASSWORD="XXXX"
echo "
===================================使用说明=============================
 1、首先请输入要配置的淘宝环境和新生成的session值
 （环境名形如t3，如果输入错误的环境号，将会把所有测试环境淘宝都关闭）
 2、然后会搜索各数据库，打印出当前淘宝打开的数据库
 3、会更新所输入环境的淘宝配置信息
 4、须重新部署相关代码以生效
=========================================================================
"
echo "请输入要配置的淘宝环境和session值:" 
read env sess
echo $env $sess

while [ ! -n "$sess" ]
do 
	echo "输入参数缺失，请重新输入"
	read env sess
	echo $env $sess
done

search1_sql="
SELECT 
    *
FROM
    i360r_deployer.t_project_property
WHERE
    (\`key\` = 'PLATFORM_TAOBAO_KEY'
        AND \`value\` = '23181571')
        OR (\`key\` = 'PLATFORM_TAOBAO_DELIVERONLY_MOCK'
        AND \`value\` = 'false')
"
		
setClose1_sql="
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '666666'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_KEY';
  
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '666666'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_SECRET';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '666666'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_SESSION';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = 'true'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_DELIVERONLY_MOCK'
"		

setOpen1_sql="
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '23181571'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_KEY';
  
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = 'f60046797b79fedf946a70ed04a45141'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_SECRET';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '${sess}'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_SESSION';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = 'false'
WHERE
    \`key\` = 'PLATFORM_TAOBAO_DELIVERONLY_MOCK'
"

search2_sql="
SELECT 
    *
FROM
    i360r_deployer.t_project_property
WHERE
    (\`key\` = 'TAOBAO_KEY'
        AND \`value\` = '23181571')
        OR (\`key\` = 'TAOBAO_DELIVERONLY_MOCK'
        AND \`value\` = 'false')
"
setClose2_sql="
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '666666'
WHERE
    \`key\` = 'TAOBAO_KEY';
  
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '666666'
WHERE
    \`key\` = 'TAOBAO_SECRET';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '666666'
WHERE
    \`key\` = 'TAOBAO_SESSION';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = 'true'
WHERE
    \`key\` = 'TAOBAO_DELIVERONLY_MOCK'
"		

setOpen2_sql="
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '23181571'
WHERE
    \`key\` = 'TAOBAO_KEY';
  
UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = 'f60046797b79fedf946a70ed04a45141'
WHERE
    \`key\` = 'TAOBAO_SECRET';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = '${sess}'
WHERE
    \`key\` = 'TAOBAO_SESSION';
    
  UPDATE i360r_deployer.t_project_property 
SET 
    \`value\` = 'false'
WHERE
    \`key\` = 'TAOBAO_DELIVERONLY_MOCK'
"

		
for hostname in ${HOSTNAME[@]}
	do
		echo "$hostname"
		echo ${hostname:0:2}
		
		if [ ${hostname:0:2} != $env ];then
			if [ ${hostname:2:2} == "01" ];then
				search_sql=$search1_sql
				setClose_sql=$setClose1_sql
			else
				search_sql=$search2_sql
				setClose_sql=$setClose2_sql
			fi
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search_sql" 
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setClose_sql" 
		else
			if [ ${hostname:2:2} == "01" ];then
				search_sql=$search1_sql
				setOpen_sql=$setOpen1_sql
			else
				search_sql=$search2_sql
				setOpen_sql=$setOpen2_sql
			fi
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$search_sql" 
			mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$setOpen_sql" 
		fi	
		
	done

read -p "Press any key to continue." var

#echo "${HOSTNAME[0]}"
#mysql -u$USERNAME -p$PASSWORD -h${HOSTNAME[0]:5:12} -P$PORT -e "$taobao1_sql"




