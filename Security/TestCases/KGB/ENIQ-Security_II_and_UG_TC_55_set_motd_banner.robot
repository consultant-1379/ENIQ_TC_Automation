*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String

*** Test Cases ***
Test wheather MOTD banner is present or not
    SSHLibrary.File Should Exist    /ericsson/security/bin/banner_motd
    SSHLibrary.File Should Exist    /etc/motd
    
    ${result}=      Get Line Count    /ericsson/security/bin/banner_motd
    ${result_1}=    Get Line Count    /etc/motd
    Should Be Equal   ${result}     ${result_1}