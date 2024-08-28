*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the server IP type
        [Tags]                      ip type                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     hostname -i | awk '{print $1}'
	${output1}=                 Execute Command                     ipcalc -s -6 -c ${output} | echo $?
	Should Contain              ${output1}                          0
