*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test checking permission of allowed users
    ${result}=               Execute Command              sudo cat /etc/cron.allow | head -1
    Should Be Equal          ${result}                    root
    ${result_1}=             Execute Command              sudo cat /etc/cron.allow | tail -1
    Should Be Equal          ${result_1}                  dcuser

Test cron conf file is not present
    ${copy}=                 Execute Command              sudo cp /etc/cron.allow /etc/cron.allow_1 && sudo rm -rf /etc/cron.allow
    ${result}=               Execute Command              sudo find /etc/cron.allow
    Should Not Be Equal      ${result}                    /etc/cron.allow
    ${copy_1}=               Execute Command              sudo cp /etc/cron.allow_1 /etc/cron.allow && sudo rm -rf /etc/cron.allow_1