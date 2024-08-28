#!/bin/bash
/usr/bin/expect << 'EOF'
spawn ssh -o StrictHostKeyChecking=no root@10.45.192.19
expect "assword: "
send "Eniq@1234\r"
sleep 3
send -- "bash /eniq/installation/core_install/bin/manage_privileged_users.bsh\r"
expect {
 "Select the action from above list "
}
send -- "1\r"
sleep 3
expect {
"How many users to be added to Privileged group? (Minimum 1 user needs to be added) "
}
send -- "1\r"
sleep 3
expect {
"Enter username 1 ( 1 of 1) "
}
send -- "adminuser\r"
sleep 3
expect {
"Enter password for adminuser "
}
send -- "Batman%1234\r"
sleep 3
expect {
"Retype new password: "
}
send -- "Batman%1234\r"
sleep 3
exit
expect eof