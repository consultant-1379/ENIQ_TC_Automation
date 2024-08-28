*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test checking permission of allowed users
    ${result}=               Execute Command              cat /etc/at.allow | head -1
    Should Be Equal          ${result}                    root
    ${result_1}=             Execute Command              cat /etc/at.allow | tail -1
    Should Be Equal          ${result_1}                  dcuser

Test at conf file is not present
    ${copy}=                 Execute Command              cp /etc/at.allow /etc/at.allow_1 && rm -rf /etc/at.allow
    ${result}=               Execute Command              find /etc/at.allow
    Should Not Be Equal      ${result}                    /etc/at.allow
    ${copy_1}=               Execute Command              cp /etc/at.allow_1 /etc/at.allow && rm -rf /etc/at.allow_1
    