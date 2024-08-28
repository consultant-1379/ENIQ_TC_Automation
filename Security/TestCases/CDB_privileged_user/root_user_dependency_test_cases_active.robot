*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../Resources/root_user_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Variables ***
    ${ip}=          Execute Command        hostname -I | awk '{print $1}'
*** Test Cases ***
Checking the SSH access for the created user.
    ${result}=                     Execute Command              sudo sshd -T | grep dummyuser
    Should Be Equal                ${result}                    allowusers dummyuser

Checking the NH script execution
    ${result}=                     Execute Command              sudo python /ericsson/security/bin/enable_tcp_syncookies.py
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      **********TCP SYN Cookies is already enabled!**********
	Should Be Equal                ${get_lines_print}           **********TCP SYN Cookies is already enabled!**********

Checking NH script without using sudo
    ${result}=                     Execute Command              python /ericsson/security/bin/enable_tcp_syncookies.py
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      Use 'sudo' to use super user privileges!
	Should Be Equal                ${get_lines_print}           Use 'sudo' to use super user privileges!

Checking the NH script execution
    ${result}=                     Execute Command              sudo python /ericsson/security/bin/enable_tcp_syncookies.py
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      **********TCP SYN Cookies is already enabled!**********
	Should Be Equal                ${get_lines_print}           **********TCP SYN Cookies is already enabled!**********

Checking NH script without using sudo
    ${result}=                     Execute Command              python /ericsson/security/bin/enable_tcp_syncookies.py
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      Use 'sudo' to use super user privileges!
	Should Be Equal                ${get_lines_print}           Use 'sudo' to use super user privileges!

Checking internal SSH access is provided to the users
    ${result}=                     Execute Command              sudo sshd -T | grep root@${ip}
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      allowusers root@${ip}
	Should Be Equal                ${get_lines_print}           allowusers root@${ip}

Checking internal SSH access for dcuser is provided
    ${result}=                     Execute Command              sudo sshd -T | grep dcuser@${ip}
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      allowusers dcuser@${ip}
	Should Be Equal                ${get_lines_print}           allowusers dcuser@${ip}

Checking the interblade SSH access of root user
    ${result}=                     Execute Command              sudo sshd -T | grep root@127.0.0.1
	${get_lines_print}=            Get Lines Matching Regexp    ${result}      root@127.0.0.1
	Should Be Equal                ${get_lines_print}           root@127.0.0.1


