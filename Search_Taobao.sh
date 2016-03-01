
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
PASSWORD="p@swrd123"


taobao1_sql="SELECT 
    *
FROM
    i360r_deployer.t_project_property
WHERE
    (\`key\` = 'PLATFORM_TAOBAO_KEY'
        AND \`value\` = '23181571')
        OR (\`key\` = 'PLATFORM_TAOBAO_DELIVERONLY_MOCK'
        AND \`value\` = 'false')"

taobao2_sql="SELECT 
    *
FROM
    i360r_deployer.t_project_property
WHERE
    (\`key\` = 'TAOBAO_KEY'
        AND \`value\` = '23181571')
        OR (\`key\` = 'TAOBAO_DELIVERONLY_MOCK'
        AND \`value\` = 'false')"

for hostname in ${HOSTNAME[@]}
	do
		echo "$hostname"
		if [ ${hostname:2:2} == "01" ];then
			taobao_sql=$taobao1_sql	
		else
			taobao_sql=$taobao2_sql
		fi
		mysql -u$USERNAME -p$PASSWORD -h${hostname:5} -P$PORT -e "$taobao_sql"
	done

read -p "Press any key to continue." var
#echo "${HOSTNAME[0]}"
#mysql -u$USERNAME -p$PASSWORD -h${HOSTNAME[0]:5:12} -P$PORT -e "$taobao1_sql"

