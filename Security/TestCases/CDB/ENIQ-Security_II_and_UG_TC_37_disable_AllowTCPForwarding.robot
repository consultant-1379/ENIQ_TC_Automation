*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary 10 seconds
Library            String
#ZAHAPBR
*** Test Cases ***
Test AllowTcpForwarding in disable AllowTcpForwarding is not set to no - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep  AllowTcpForwarding
   Should Not Contain         ${negative_expected}              AllowTcpForwarding no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test AllowTcpForwarding in disable AllowTcpForwarding is set to no - Positive scenario
    ${result}=               Execute Command              cat /etc/ssh/sshd_config | grep AllowTcpForwarding | grep -v "^#.AllowTcpForwarding"
    ${get_lines_dtf}=        Get Lines Matching Regexp    ${result}      AllowTcpForwarding no
    Should Be Equal    ${get_lines_dtf}                   AllowTcpForwarding no

Test AllowTcpForwarding is disabled on SSH daemon - Verifying system daemon
    ${result}=        Execute Command       sshd -T | grep allowtcpforwarding
    ${get_lines_dtf}=        Get Lines Matching Regexp    ${result}      allowtcpforwarding no
    Should Be Equal     ${get_lines_dtf}       allowtcpforwarding no