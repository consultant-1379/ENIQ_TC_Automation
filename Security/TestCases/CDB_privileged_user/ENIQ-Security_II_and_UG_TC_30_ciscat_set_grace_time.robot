*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test login grace time parameter is not set to 1m - Negative scenario
   ${file_existence}=        Execute Command          sudo test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/LoginGraceTime 1m/LoginGraceTime 10m/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo cat /root/sshd_backup.conf | grep  LoginGraceTime
   Should Not Contain         ${negative_expected}              LoginGraceTime 1m
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test login grace time parameter is 1m - Positive scenario
    ${result}=  Execute Command   sudo cat /etc/ssh/sshd_config | grep LoginGraceTime
    Should Be Equal     ${result}       LoginGraceTime 1m

Test Login grace is is enforced to 60 seconds on SSH daemon - Verifying system daemon
    ${result}=        Execute Command       sudo sshd -T | grep logingracetime
    ${get_lines_lgt}=        Get Lines Matching Regexp    ${result}      logingracetime 60  
    Should Be Equal     ${get_lines_lgt}       logingracetime 60