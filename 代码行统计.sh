#!/bin/sh

#gitinspector工具所在的目录
gitinspectorPATH="/d/project/gitinspector"

#代码所在的目录
projectPATH="/d/project/"

#生成文件所在的目录
productPATH="/d/"

#上月的月初和月末时间
lastMonthBegin=`date -d last-month +%Y-%m-01`
lastMonthEnd=`date -d "\`date -d ''$lastMonthBegin' +1 month' +%Y-%m-01\`-1 day" +%F`

#当月的月初
currentMonthBegin=`date +%Y-%m-01`
#currenMonthEnd=`date -d "\`date -d ''$currenMonthBegin' +1 month' +%Y-%m-01\`-1 day" +%F`

#代码的项目
PROJECT=(
"i360r-android"
"i360r-bpm"
"i360r-cas"
"i360r-commerce"
"i360r-content"
"i360r-coupon"
"i360r-delivery"
"i360r-framework"
"i360r-marketing"
#"i360r-platform"
"i360r-rop"
"i360r-statistics"
"i360r-tools"
"i360r-web"
)

echo "请输入L或者C，用来选择统计上月（L-lastMonth）或者当月（C-currentMonth）的所有项目"
read whichMonth

#判断要统计上月还是当月
while ( [ $whichMonth != 'C' ] && [ $whichMonth != 'L' ] )
do 
	echo "输入有误，请重新输入"
	read whichMonth
done

#根据C或L生成相应的gitinspector工具指令
if [ $whichMonth == "L" ];then
	time="--since=$lastMonthBegin --until=$lastMonthEnd"
else 
	time="--since=$currentMonthBegin"
fi	
echo $time

#循环处理：
for project in ${PROJECT[@]}
	do
		cd $projectPATH$project
		git checkout master
		git pull origin
		
		cd $gitinspectorPATH
		python gitinspector.py  --file-types=java,js,jsp,properties,tmpl,xml --format=html -T $time -L -l -r /d/project/$project > $productPATH$project.html
	done



read -p "Press any key to continue." var
