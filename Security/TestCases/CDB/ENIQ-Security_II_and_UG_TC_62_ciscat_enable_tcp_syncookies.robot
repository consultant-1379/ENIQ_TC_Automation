*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test tcp syn cookies is not set to 1 - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/net.ipv4.tcp_syncookies=1/net.ipv4.tcp_syncookies=0/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sysctl_backup.conf | grep  net.ipv4.tcp_syncookies
   Should Not Contain         ${negative_expected}              net.ipv4.tcp_syncookies=1
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test tcp syn cookies is set to 1 - Positive scenario
    ${result}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.tcp_syncookies
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv4.tcp_syncookies=1
	Should Be Equal     ${sysctl_file_check}       net.ipv4.tcp_syncookies=1 
 
Test syn cookies is enforced in sysctl daemon - Verifying system daemon
    ${sysctl_check}=        Execute Command       sysctl -n net.ipv4.tcp_syncookies
    Should Be Equal    ${sysctl_check}    1
