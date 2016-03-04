#!/bin/sh

user="shbj"
password="shbj123"

ip="58.68.148.52"
proj="delivery"
num="359"

function deploy(){
/bin/expect <<EOF
set timeout 90
spawn ssh $user@$1
expect {  
"*yes/no" { send "yes\r"; exp_continue}  
"*password:" { send "$password\r" }  
} 
#expect "~]$*"  #识别太慢，why？
send "echo y | deployer -d -p $2 -b $3 -t \r"
#interact
send "exit\r"
expect eof
EOF
}
deploy "$ip" "$proj" "$num"