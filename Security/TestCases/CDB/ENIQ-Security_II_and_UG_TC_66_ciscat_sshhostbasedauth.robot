*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String


*** Test Cases ***
Test HostbasedAuthentication parameter is not set to no - Negative Scenario

   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/hostbasedauthentication no/hostbasedauthentication yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep  hostbasedauthentication
   Should Not Contain         ${negative_expected}              hostbasedauthentication no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test HostbasedAuthentication parameter is no - Positive Scenario
    ${result}=  Execute Command         cat /etc/ssh/sshd_config | grep HostbasedAuthentication
	${get_lines_ms}=        Get Lines Matching Regexp    ${result}      HostbasedAuthentication no
    Should Be Equal     ${get_lines_ms}       HostbasedAuthentication no

Test HostbasedAuthentication is disabled on SSH daemon - Verifying system daemon
    ${result}=        Execute Command       sshd -T | grep hostbasedauthentication
    ${get_lines_hba}=        Get Lines Matching Regexp    ${result}      hostbasedauthentication no
    Should Be Equal     ${get_lines_hba}       hostbasedauthentication no
