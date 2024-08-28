*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt




*** Test Cases ***
To verify privileged user added must be part of ENIQ_ADMIN_ROLE group
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${value}=                   Execute Command             cat /etc/group | grep ENIQ_ADMIN_ROLE | cut -f3 -d":"
    ${output}=                  Execute Command             cat /etc/passwd | grep ${value} 
    Should Contain              ${output}                   ${value}


