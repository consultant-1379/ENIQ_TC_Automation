*** Settings ***
Suite Setup        Open Connection and SSH Login for root dependency
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
Library            Process

*** Test Cases ***
Checking the SSH access for the created user.
    ${result}=                     Execute Command              sudo sshd -T | grep adminuser
    Should Be Equal                ${result}                    allowusers adminuser

Checking the NH script execution
    ${result}=                     Run Process         sudo    python    /ericsson/security/bin/enable_tcp_syncookies.py
    ${rc}=                         Convert To Number    0
	  Should Be Equal                ${result.rc}         ${rc}
Checking NH script without using sudo
    ${result}=                     Execute Command              python /ericsson/security/bin/enable_tcp_syncookies.py
	  ${get_lines_print}=            Get Lines Matching Regexp    ${result}      Use 'sudo' to use super user privileges!
	  Should Be Equal                ${get_lines_print}           Use 'sudo' to use super user privileges!

Checking internal SSH access for root user is provided
    ${result}=                     Execute Command              sudo sshd -T | grep root@10.45.192.19
	  ${get_lines_print}=            Get Lines Matching Regexp    ${result}      allowusers root@10.45.192.19
  	Should Be Equal                ${get_lines_print}           allowusers root@10.45.192.19

Checking internal SSH access for dcuser is provided
    ${result}=                     Execute Command              sudo sshd -T | grep dcuser@10.45.192.19
  	${get_lines_print}=            Get Lines Matching Regexp    ${result}      allowusers dcuser@10.45.192.19
	  Should Be Equal                ${get_lines_print}           allowusers dcuser@10.45.192.19

Checking root switch
    ${result}=                     Execute Command             sudo -i
    ${result_1}=                   Execute Command             whoami
	  Should Be Equal                ${result_1}               adminuser

