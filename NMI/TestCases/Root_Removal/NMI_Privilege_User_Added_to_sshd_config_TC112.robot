*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking that /etc/sshd_config file is populated with the new user added
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             sudo cat /etc/ssh/sshd_config | grep AllowUsers
    Should Contain              ${output}                   root@
