*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
Library            Collections

*** Test Cases ***
Checking sudo log file contents
    ${result}=                   Execute Command          sudo cat /etc/logrotate.d/sudo
	  ${sysctl_file_check}=        Split String             ${result}      
	  Collections.List Should Contain Value          ${sysctl_file_check}     /var/log/sudo.log
    Collections.List Should Contain Value          ${sysctl_file_check}     {
    Collections.List Should Contain Value          ${sysctl_file_check}     daily
    Collections.List Should Contain Value          ${sysctl_file_check}     compress
    Collections.List Should Contain Value          ${sysctl_file_check}     size
    Collections.List Should Contain Value          ${sysctl_file_check}     20M
    Collections.List Should Contain Value          ${sysctl_file_check}     rotate
    Collections.List Should Contain Value          ${sysctl_file_check}     1
    Collections.List Should Contain Value          ${sysctl_file_check}     create
    Collections.List Should Contain Value          ${sysctl_file_check}     dateext
    Collections.List Should Contain Value          ${sysctl_file_check}     postrotate
    Collections.List Should Contain Value          ${sysctl_file_check}     restart
    Collections.List Should Contain Value          ${sysctl_file_check}     endscript
    Collections.List Should Contain Value          ${sysctl_file_check}     }

Checking sudo log file wc
    ${result}=                   Execute Command          sudo wc -w /etc/logrotate.d/sudo
    Should Be Equal              ${result}                16 /etc/logrotate.d/sudo

Checking sudo log file line count
    ${result}=                   Execute Command          sudo wc -l /etc/logrotate.d/sudo
    Should Be Equal              ${result}                12 /etc/logrotate.d/sudo

Checking sudo log charecter count
    ${result}=                   Execute Command          sudo wc -m /etc/logrotate.d/sudo
    Should Be Equal              ${result}                157 /etc/logrotate.d/sudo
    
    