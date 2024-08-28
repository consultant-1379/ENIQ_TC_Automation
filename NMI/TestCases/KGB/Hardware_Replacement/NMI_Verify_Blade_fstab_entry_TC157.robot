*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking if storadm contains file
	[Tags]                      SB
	Set Client Configuration    timeout=25 seconds      prompt=#:
	${output}=                  Execute Command         cat /etc/shadow | grep -i "storadm"
	Should Contain              ${output}               storadm

Checking if /etc/shadow contains file
	[Tags]                      SB
	Set Client Configuration    timeout=25 seconds      prompt=#:
	${output}=                  Execute Command         awk -F':' '{print NF; if(NF != 9) {exit 1}}' /etc/shadow  && echo "Pass" || echo "Fail"
	Should Not Contain          ${output}               Fail  
