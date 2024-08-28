*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test su command is configured properly or not
    ${result}=  Execute Command         cat /etc/pam.d/su | grep sugroup | cut -c 60-66
    Should Be Equal     ${result}       sugroup