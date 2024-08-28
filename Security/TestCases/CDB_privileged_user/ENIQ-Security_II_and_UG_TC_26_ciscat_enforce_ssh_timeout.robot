*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test enforce ssh timeout parameters ClientAliveInterval,ClientAliveCountMax values are not 900,0 - Negative scenario
   ${file_existence}=        Execute Command          sudo test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/ClientAliveInterval 300/ClientAliveInterval 600/g; s/ClientAliveCountMax 3/ClientAliveCountMax 10/' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo grep  -e "ClientAliveInterval" -e "ClientAliveCountMax" /root/sshd_backup.conf
   Should Not Contain         ${negative_expected}              ClientAliveInterval 300           ClientAliveCountMax 3
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test enforce ssh timeout parameters ClientAliveInterval,ClientAliveCountMax values are 300,3 - Positive scenario
    ${result}=      Execute Command     sudo cat /etc/ssh/sshd_config | grep ClientAliveInterval
    Should Be Equal     ${result}       ClientAliveInterval 300
	${result1}=      Execute Command     sudo cat /etc/ssh/sshd_config | grep ClientAliveCountMax
	Should Be Equal     ${result1}       ClientAliveCountMax 3

Test ssh timeout is enforced on SSH daemon - verifying system daemon
    ${result1}=        Execute Command       sudo sshd -T | grep clientaliveinterval
    ${result2}=        Execute Command       sudo sshd -T | grep clientalivecountmax
    ${get_lines_ms1}=        Get Lines Matching Regexp    ${result1}      clientaliveinterval 300
    ${get_lines_ms2}=        Get Lines Matching Regexp    ${result2}      clientalivecountmax 3
    Should Be Equal     ${get_lines_ms1}       clientaliveinterval 300
    Should Be Equal     ${get_lines_ms2}       clientalivecountmax 3
 

