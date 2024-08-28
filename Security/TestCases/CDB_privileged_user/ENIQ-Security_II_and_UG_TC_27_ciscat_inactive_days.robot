*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test account lockout inactive days parameter is configured properly or not
    ${result}=  Checking the parameter
    Should Be Equal     ${result}       Success
 
*** Keywords ***
Open Connection and SSH Login
    Open Connection    ${host}    port=${port}
    Login    ${username}    ${password}    delay=1
 
Checking the parameter
    ${grepdata}=        Execute Command       sudo useradd -D | grep INACTIVE
    IF    '${grepdata}' == 'INACTIVE=30'
       ${result}=    Execute Command         sudo echo Success
    ELSE
       ${result}=    Execute Command         sudo echo Failed
    END
    [Return]    ${result}
