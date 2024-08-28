*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
Library            Collections

*** Test Cases ***
Checking sudo-i file contents
    ${result}=                   Execute Command          sudo cat /etc/pam.d/sudo-i
	  ${sysctl_file_check}=        Split String             ${result}      
	  Collections.List Should Contain Value          ${sysctl_file_check}     auth
    Collections.List Should Contain Value          ${sysctl_file_check}     required
    Collections.List Should Contain Value          ${sysctl_file_check}     sudo
    Collections.List Should Contain Value          ${sysctl_file_check}     sudo
    Collections.List Should Contain Value          ${sysctl_file_check}     account
    Collections.List Should Contain Value          ${sysctl_file_check}     sufficient
    Collections.List Should Contain Value          ${sysctl_file_check}     password
    Collections.List Should Contain Value          ${sysctl_file_check}     include
    Collections.List Should Contain Value          ${sysctl_file_check}     session
    Collections.List Should Contain Value          ${sysctl_file_check}     optional
    Collections.List Should Contain Value          ${sysctl_file_check}     pam_keyinit.so  
    Collections.List Should Contain Value          ${sysctl_file_check}     force
    Collections.List Should Contain Value          ${sysctl_file_check}     revoke
    Collections.List Should Contain Value          ${sysctl_file_check}     session

Checking sudo-i file wc
    ${result}=                   Execute Command          sudo wc -w /etc/pam.d/sudo-i
    Should Be Equal              ${result}                18 /etc/pam.d/sudo-i

Checking sudo-i file line count
    ${result}=                   Execute Command          wc -l /etc/pam.d/sudo-i
    Should Be Equal              ${result}                6 /etc/pam.d/sudo-i

Checking sudo-i charecter count
    ${result}=                   Execute Command          wc -m /etc/pam.d/sudo-i
    Should Be Equal              ${result}                193 /etc/pam.d/sudo-i
    
    