*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String

*** Test Cases ***
Test wheather MOTD banner is present or not
    SSHLibrary.File Should Exist    /ericsson/security/bin/banner_ssh
    SSHLibrary.File Should Exist    /etc/issue.net
    
    ${result}=      Get Line Count    /ericsson/security/bin/banner_ssh
    ${result_1}=    Get Line Count    /etc/issue.net
    Should Be Equal   ${result}     ${result_1}