*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            String

*** Test Cases ***
Test AllowAgentForwarding is not no - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/AllowAgentForwarding no/AllowAgentForwarding yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep  AllowAgentForwarding
   Should Not Contain         ${negative_expected}              AllowAgentForwarding no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test AllowAgentForwarding is no - Positive scenario
    ${result}=  Execute Command   cat /etc/ssh/sshd_config | grep AllowAgentForwarding
    Should Be Equal     ${result}        AllowAgentForwarding no

Test AllowAgentForwarding is set to no in sysctl daemon - verifying system daemon
    ${result}=        Execute Command       sshd -T | grep allowagentforwarding
    ${get_lines_af}=        Get Lines Matching Regexp    ${result}      allowagentforwarding no
    Should Be Equal     ${get_lines_af}       allowagentforwarding no

