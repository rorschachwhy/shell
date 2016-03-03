#!/bin/expect -f
#set timeout 30
spawn ssh shbj@58.68.148.52
expect {
"*yes/no" {send "yes\r"; exp_continue}
"*password:" { send "shbj123\r" }
}
expect "$*"
send "pwd\r"
#send "exit\r"
expect eof
read var

