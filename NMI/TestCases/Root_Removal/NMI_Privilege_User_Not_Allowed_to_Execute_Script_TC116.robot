*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Library            String
Resource           ../../Resources/resource.txt


*** Test Cases ***
Checking that privilege user is not allowed to execute manage_privilege_users script
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds          prompt=#:
    ${output}=                  Execute Command             bash /eniq/installation/core_install/bin/manage_privileged_users.bsh
    Should Contain              ${output}                   You must be root to execute this script
