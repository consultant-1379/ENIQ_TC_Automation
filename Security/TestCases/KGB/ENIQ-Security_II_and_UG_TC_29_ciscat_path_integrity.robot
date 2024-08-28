*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test root path integrity is configured properly or not
    ${result}=              Execute Command         cat /root/.bash_profile | grep PATH= | cut -c 2-21
    Should Be Equal         ${result}               PATH=$PATH:$HOME/bin
