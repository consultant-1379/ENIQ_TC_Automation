*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String

*** Variables ***
${syslog_path}    /etc/logrotate.d/syslog
${motd_path}    /ericsson/security/bin/Cron_Log
${cron_path}    /etc/logrotate.d/cron

*** Keywords ***
Open Connection And Log In
   Open Connection     ${HOST}    port=${port}
   Login               ${USERNAME}        ${PASSWORD}    delay=1

*** Test Cases ***
Test wheather files are present or not
    SSHLibrary.File Should Exist    ${syslog_path}
    SSHLibrary.File Should Exist    ${motd_path}
    SSHLibrary.File Should Exist    ${cron_path}
    
Test wheather syslog is set or not
    ${maillog}=  Execute Command     sudo cat /etc/logrotate.d/syslog | grep /var/log/maillog
    ${messages}=  Execute Command     sudo cat /etc/logrotate.d/syslog | grep /var/log/messages
    ${secure}=  Execute Command     sudo cat /etc/logrotate.d/syslog | grep /var/log/secure
    ${spooler}=  Execute Command     sudo cat /etc/logrotate.d/syslog | grep /var/log/spooler
    #${syslogd_pid}=  Execute Command     sudo cat /etc/logrotate.d/syslog | grep /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
    
    #Log  Num value is ${syslogd_pid}  console=yes
    
    Should Be Equal     ${maillog}    /var/log/maillog
    Should Be Equal     ${messages}    /var/log/messages
    Should Be Equal     ${secure}    /var/log/secure
    Should Be Equal     ${spooler}    /var/log/spooler
    #Should Be Equal     ${syslogd_pid}    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
    
Test wheather logrotate.d/cron is set or not

    ${daily}=    Execute Command     sudo cat /etc/logrotate.d/cron | grep daily
    ${create}=  Execute Command     sudo cat /etc/logrotate.d/cron | grep create
    ${dateext}=  Execute Command     sudo cat /etc/logrotate.d/cron | grep dateext
    
    Should Be Equal    ${daily}    daily
    Should Be Equal    ${create}    create
    Should Be Equal    ${dateext}    dateext
    

    