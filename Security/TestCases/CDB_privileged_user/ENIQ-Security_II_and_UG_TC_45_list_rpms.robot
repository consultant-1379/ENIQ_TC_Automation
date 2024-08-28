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
Test wheather rpms file are exist in directory
    ${output}=    Execute Command    sudo ls -al /ericsson/security/log/rpm_logs/ | wc -l
    Should Not Be Equal     ${output}    3