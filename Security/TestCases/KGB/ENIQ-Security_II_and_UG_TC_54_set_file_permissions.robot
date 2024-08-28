*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String

*** Test Cases ***
Check File Permission
    SSHLibrary.File Should Exist    /etc/at.allow
    SSHLibrary.File Should Exist    /etc/at.deny
    SSHLibrary.File Should Exist    /etc/cron.allow
    SSHLibrary.File Should Exist    /etc/crontab

Check Directory Permissions
    SSHLibrary.Directory Should Exist    /etc/cron.d
    SSHLibrary.Directory Should Exist    /etc/cron.daily
    SSHLibrary.Directory Should Exist    /etc/cron.hourly
    SSHLibrary.Directory Should Exist    /etc/cron.weekly
    SSHLibrary.Directory Should Exist    /etc/cron.monthly

Check Permissions
    SSHLibrary.File Should Exist    /etc/at.allow
    SSHLibrary.File Should Exist    /etc/at.deny
    SSHLibrary.File Should Exist    /etc/cron.allow
    SSHLibrary.File Should Exist    /etc/crontab
    SSHLibrary.Directory Should Exist    /etc/cron.d
    SSHLibrary.Directory Should Exist    /etc/cron.daily
    SSHLibrary.Directory Should Exist    /etc/cron.hourly
    SSHLibrary.Directory Should Exist    /etc/cron.weekly
    SSHLibrary.Directory Should Exist    /etc/cron.monthly
