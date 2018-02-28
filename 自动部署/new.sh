#!/bin/sh
#set timeout 30

user="shbj"
password="XXXX"

ip="58.68.148.52"
proj="bpm"
num="612"
function deploy(){
/bin/expect <<EOF
spawn ssh $user@$1
expect {
"*yes/no" {send "yes\r"; exp_continue}
"*password:" { send "$password\r" }
}
expect "$*"
set dd "echo y | deployer -d -p $2 -b @3 -t"
send "$dd\r"
send "exit\r"
expect eof
#read var
EOF
}
deploy "$ip" "$proj" "$num"
