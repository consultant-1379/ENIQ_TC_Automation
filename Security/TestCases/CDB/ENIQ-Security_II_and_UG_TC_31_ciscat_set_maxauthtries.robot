*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test MaxAuthTries parameter is not set to 4 - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/MaxAuthTries 4/MaxAuthTries 2/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep  MaxAuthTries
   Should Not Contain         ${negative_expected}              MaxAuthTries 4
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test MaxAuthTries parameter is set to 4 - Positive scenario
    ${result}=  Execute Command   cat /etc/ssh/sshd_config | grep MaxAuthTries
    Should Be Equal     ${result}       MaxAuthTries 4
    
Test MaxAuthTries is enforced to 4 on SSH daemon - Verifying system daemon
    ${result}=        Execute Command       sshd -T | grep maxauthtries
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      maxauthtries 4  
    Should Be Equal     ${get_lines_mat}       maxauthtries 4