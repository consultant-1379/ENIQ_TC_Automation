*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            SSHLibrary  10 seconds
Library            String

*** Keywords ***
Open Connection and SSH Login
    Open Connection    ${host}    port=${port}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
Test wheather profile is present or not
    ${result}=         Execute Command              sudo find /etc/profile
    ${profile}=        Get Lines Matching Regexp    ${result}        /etc/profile
    Should Be Equal     ${profile}                  /etc/profile
       

Test wheather automatic logout set or not
    ${result}=         Execute Command              sudo cat /etc/profile | grep TMOUT=
    ${profile}=        Get Lines Matching Regexp    ${result}        TMOUT=900
    Should Be Equal    ${profile}                  TMOUT=900
        