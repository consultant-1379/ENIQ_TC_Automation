*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
*** Test Cases ***
Test GatewayPorts in disable GatewayPorts is not set to no - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/GatewayPorts no/GatewayPorts yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep GatewayPorts
   Should Not Contain         ${negative_expected}             GatewayPorts no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test GatewayPorts in disable GatewayPorts is set to no - Positive scenario
    ${result}=               Execute Command              cat /etc/ssh/ssh_config | grep GatewayPorts
    ${get_lines_gwp}=        Get Lines Matching Regexp    ${result}      GatewayPorts no
    Should Be Equal    ${get_lines_gwp}                   GatewayPorts no

Test GatewayPorts is disabled on SSH daemon - Verifying system daemon
    ${result}=        Execute Command       sshd -T | grep gatewayports
    ${get_lines_gwp}=        Get Lines Matching Regexp    ${result}      gatewayports no
    Should Be Equal     ${get_lines_gwp}       gatewayports no