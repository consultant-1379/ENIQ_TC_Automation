*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test MaxStartups parameter is not set to 10:30:60 - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/MaxStartups 10:30:60/MaxStartups 20:60:90/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep  MaxStartups
   Should Not Contain         ${negative_expected}              MaxStartups 10:30:60
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n


Test MaxStartups parameter is set to 10:30:60 - Positive scenario
    ${result}=  Execute Command   cat /etc/ssh/sshd_config | grep MaxStartups
    Should Be Equal     ${result}       MaxStartups 10:30:60

Test MaxStartups is enforced to 10:30:60 on SSH daemon - Verifying system daemon
    ${result}=        Execute Command       sshd -T | grep maxstartups
    ${get_lines_ms}=        Get Lines Matching Regexp    ${result}      maxstartups 10:30:60
    Should Be Equal     ${get_lines_ms}       maxstartups 10:30:60
