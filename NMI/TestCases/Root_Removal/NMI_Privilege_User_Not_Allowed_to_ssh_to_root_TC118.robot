*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking that privilege user is not allowed to ssh to root
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${value}=                   Execute Command             cat /eniq/installation/config/service_names | grep licenceservice | cut -f3 -d":"
    Write                       ssh root@${value}
    ${output}=                  Read Until Regexp           :
    Should Not Contain          ${output}                   {root}
