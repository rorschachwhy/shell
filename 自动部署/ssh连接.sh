#!/usr/bin/expect -f  

     spawn ssh shbj@58.68.148.52  
     expect {  
     "*yes/no" { send "yes\r"; exp_continue}  
     "*password:" { send "shbj123\r" }  
     } 
     interact