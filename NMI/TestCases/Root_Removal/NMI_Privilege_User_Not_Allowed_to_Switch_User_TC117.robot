*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking that privilege user is not allowed to switch user
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds          prompt=#:
    Write                       sudo su -
    ${output}=                  Read Until Regexp           :
    Should Contain              ${output}                   not allowed to execute
