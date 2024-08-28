*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test Verifyhostkeydns is set to ask
    ${result}=               Execute Command   cat /etc/ssh/ssh_config | grep Verifyhostkeydns
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      Verifyhostkeydns ask
    Should Be Equal          ${result}       Verifyhostkeydns ask

Test stricthostkeychecking is set to ask
    ${result}=               Execute Command   cat /etc/ssh/ssh_config | grep stricthostkeychecking
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      stricthostkeychecking ask
    Should Be Equal          ${result}       stricthostkeychecking ask



