
#!/bin/sh

HOSTNAME01=(
"t101=58.68.148.50"
"t201=58.68.233.90"
#"t301=123.56.16.9"
"t401=58.68.148.59"
"t501=58.68.224.154"
"t601=58.68.148.57"
)
HOSTNAME0212=(
"t102=58.68.148.51"
"t202=58.68.233.91"
#"t302=123.56.16.14"
"t402=58.68.148.60"
"t502=58.68.224.155"
"t602=58.68.148.58"

"t112=58.68.148.53"
"t212=58.68.233.93"
#"t312=123.56.16.24"
)
HOSTNAME11=(
"t111=58.68.148.52"
"t211=58.68.233.92"
#"t311=123.56.16.19"
"t411=58.68.148.61"
"t511=58.68.224.156"
"t611=58.68.233.94"
)


#echo shbj123  | ssh shbj@58.68.148.61 

#sshpass -p shbj123 ssh shbj@58.68.148.6

echo "请输入要部署的环境（all表示非阿里云的环境；或者使用t1 t2 t5）"
read -a envs
echo ${envs[0]},${envs[1]},${envs[2]}
#
#echo "请输入要部署的项目和build号（如bpm 12 delivery 34）"
#read -a info
#
#len=${#info[@]}
#echo $len
#
#while [ $len/2 == 1 ]
#do
#	echo "输入参数缺失，请重新输入"
#	read -a info
#done

#$1为数组，$2为元素，返回true表示元素在数组内
#isIn(){
#	if [[ "$1[*]" != "$1[*]" ]];then
#		return 1
#	else
#		return 0
#	fi
#}
#
#echo `isIn env "t2"`
#
#if [ $(isIn env "t2") = "ture" ];then
#	echo "OK"
#else
#	echo "wrong"
#fi

#判断数组中是否有给定元素
#参数：1 数组; 2 元素
#返回：yes/no
#例子：
#    判断数组 xrsh_array 中是否有元素 i3
#    xrsh_array=(i1,i2,i3)
#    xrsh_tmp=`echo ${xrsh_array[*]}`
#    xrsh_arrhasitem "$xrsh_tmp" "i3"
#    返回 yes
#注意：数组作为参数使用时需要先转换

envs_tmp=`echo ${envs[*]}`
function isIn()
{
	local tmp
	local array=`echo "$1"`
	for tmp in ${array[*]}; 
	do
 #  if test "$2" = "$tmp"; then  #这种方法也是可以的，使用test
		if [ "$2" = "$tmp" ];then
			echo yes
			return
		fi		
	done
	echo no
}
a=`isIn "$envs_tmp" "t3"`
#echo $a
if [ "$a" = "yes" ];then
	echo OK
fi

function deploy()
{
	spawn ssh shbj@58.68.148.52
	expect {
		"*yes/no" {send "yes\r"; exp_continue}
		"*password:" { send "shbj123\r" }
		}
	expect "$*"
	send "pwd\r"
	#send "exit\r"

}

#for  ((i=0;i<($len/2);i++))
#	do
#		echo $i
#		echo ${info[$i*2]},${info[$i*2+1]}
#		
#		if [ ${info[$i*2]} = "platform" ] ||[ ${info[$i*2]} = "marketing" ];then
#			echo "01"
#			for host01 in ${HOSTNAME01[@]}
#				do
#					if [ $envs = "all" ];then
#						#ssh
#						#echo y | deployer -d -p ${info[$i*2]} -b ${info[$i*2+1]} -t &
#						#exit()
#					elif [  ];then 
#						#ssh
#						#echo y | deployer -d -p ${info[$i*2]} -b ${info[$i*2+1]} -t &
#						#exit()
#					fi
#				done
#		elif [ ${info[$i*2]} = "rop" ];then
#			echo "02/12"
#			for host0212 in ${HOSTNAME0212[@]}
#				do
#					#ssh
#					#echo y | deployer -d -p ${info[$i*2]} -b ${info[$i*2+1]} -t &
#					#exit()
#				done
#		else 
#			echo "11"
#			for host11 in ${HOSTNAME11[@]}
#				do
#					#ssh
#					#echo y | deployer -d -p ${info[$i*2]} -b ${info[$i*2+1]} -t &
#					#exit()
#				done
#		fi		
#
#	done


read var