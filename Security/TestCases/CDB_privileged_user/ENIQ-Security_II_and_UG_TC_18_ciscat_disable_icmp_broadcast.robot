*** Settings ***    
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test disable icmp broadcast parameter values are not 1 - Negative scenario

   ${file_existence}=        Execute Command          sudo test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudp cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/net.ipv4.icmp_echo_ignore_broadcasts=1/net.ipv4.icmp_echo_ignore_broadcasts=0/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo cat /root/sysctl_backup.conf | grep  net.ipv4.icmp_echo_ignore_broadcasts
   Should Not Contain         ${negative_expected}              net.ipv4.icmp_echo_ignore_broadcasts=1
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable icmp broadcast parameter values are 1 - Positive scenario
    ${result}=               Execute Command              sudo cat /etc/sysctl.conf | grep net.ipv4.icmp_echo_ignore_broadcasts
    ${get_lines_ibd}=        Get Lines Matching Regexp    ${result}      net.ipv4.icmp_echo_ignore_broadcasts=1
    Should Be Equal    ${get_lines_ibd}                   net.ipv4.icmp_echo_ignore_broadcasts=1

Test ignore icmp broadcast is enforced in sysctl daemon - verifying system daemon
    ${sysctl_check1}=        Execute Command      sudo sysctl -n net.ipv4.icmp_echo_ignore_broadcasts
    Should Be Equal    ${sysctl_check1}    1

Test disable ip forward parameter values are not 0 - Negative scenario
   ${file_existence}=        Execute Command          sudo test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/net.ipv4.ip_forward=0/net.ipv4.ip_forward=1/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo cat /root/sysctl_backup.conf | grep  net.ipv4.ip_forward
   Should Not Contain         ${negative_expected}              net.ipv4.ip_forward=0
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable ip forward parameter values are 0 - Positive scenario
    ${result}=               Execute Command              sudo cat /etc/sysctl.conf | grep net.ipv4.ip_forward
    ${get_lines_if}=        Get Lines Matching Regexp    ${result}      net.ipv4.ip_forward=0
    Should Be Equal    ${get_lines_if}                   net.ipv4.ip_forward=0

Test ip forward is enforced in sysctl daemon - verifying system daemon
    ${sysctl_check1}=        Execute Command       sudo sysctl -n net.ipv4.ip_forward
    Should Be Equal    ${sysctl_check1}    0