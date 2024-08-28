*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test PermitEmptyPasswords parameter is not set to no - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep  PermitEmptyPasswords
   Should Not Contain         ${negative_expected}              PermitEmptyPasswords no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test PermitEmptyPasswords parameter is no - Positive scenario
    ${result}=      Execute Command     cat /etc/ssh/sshd_config | grep PermitEmptyPasswords
    Should Be Equal     ${result}       PermitEmptyPasswords no
    
Test PermitEmptyPasswords is enforced on SSH daemon - verifying system kernel
    ${result}=        Execute Command       sshd -T | grep permitempty
    ${get_lines_pep}=        Get Lines Matching Regexp    ${result}      permitemptypasswords no
    Should Be Equal     ${get_lines_pep}       permitemptypasswords no