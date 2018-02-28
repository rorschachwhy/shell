#!/bin/sh
/bin/expect <<EOF
set timeout 60
spawn ssh shbj@58.68.148.52  
expect {  
"*yes/no" { send "yes\r"; exp_continue}  
"*password:" { send "XXXX\r" }  
} 
expect "$*"
send "echo y | deployer --start -p delivery\r"
send "exit\r"
expect eof
EOF
