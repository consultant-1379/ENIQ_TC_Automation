*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
#ZAHAPBR
*** Test Cases ***
Test firewalld is active and enabled in enable firewall
    ${result}=    Checking the parameter      
    Should Be Equal    ${result}    Success

Test firewalld in not active and not enabled in enable firewall
    ${check1}=    Execute Command    systemctl status firewalld | grep -i Active | cut -d':' -f 2 | cut -d ' ' -f 2
    ${check2}=    Execute Command    systemctl status firewalld | grep Loaded | cut -d ';' -f 2 | cut -d ' ' -f 2
    IF    '${check1}' == 'active' or '${check2}' == 'enabled'
        Execute Command    systemctl stop firewalld
        Execute Command    systemctl disable firewalld > /dev/null 2>&1
        Execute Command    firewall-cmd --reload > /dev/null 2>&1
    END
    ${result} =    Checking the parameter
    Should be Equal    ${result}    Failed
    Execute Command    systemctl start firewalld
    Execute Command    systemctl enable firewalld > /dev/null 2>&1
    Execute Command    firewall-cmd --reload > /dev/null 2>&1

*** Keywords ***
Checking the parameter
    ${check1}=    Execute Command    systemctl status firewalld | grep -i Active | cut -d':' -f 2 | cut -d ' ' -f 2
    ${check2}=    Execute Command    systemctl status firewalld | grep Loaded | cut -d ';' -f 2 | cut -d ' ' -f 2
    IF    '${check1}' == 'active' and '${check2}' == 'enabled'
        ${result}=    Execute Command    echo Success
    ELSE
        ${result}=    Execute Command    echo Failed
    END
    [Return]    ${result}   