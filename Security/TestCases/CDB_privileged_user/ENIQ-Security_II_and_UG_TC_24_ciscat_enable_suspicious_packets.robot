*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test disable suspicious packet when detected is not set to 1 - Negative scenario

   ${file_existence}=        Execute Command          sudo test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/net.ipv4.conf.all.log_martians=1/net.ipv4.conf.all.log_martians=0/g; s/net.ipv4.conf.default.log_martians=1/net.ipv4.conf.default.log_martians=0/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo grep  -e "net.ipv4.conf.all.log_martians" -e "net.ipv4.conf.default.log_martians" /root/sysctl_backup.conf 
   Should Not Contain         ${negative_expected}              net.ipv4.conf.all.log_martians=1       net.ipv4.conf.default.log_martians=1
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable suspicious packet when detected is set to 1 - Positive scenario
    ${result}=      Execute Command       sudo cat /etc/sysctl.conf | grep net.ipv4.conf.all.log_martians
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv4.conf.all.log_martians=1
	Should Be Equal     ${sysctl_file_check}       net.ipv4.conf.all.log_martians=1

    ${result1}=      Execute Command       sudo cat /etc/sysctl.conf | grep net.ipv4.conf.default.log_martians
	${sysctl_file_check1}=        Get Lines Matching Regexp    ${result1}      net.ipv4.conf.default.log_martians=1
	Should Be Equal     ${sysctl_file_check1}       net.ipv4.conf.default.log_martians=1

Test disabling Ipv6 advertisements is enforced in sysctl daemon - verifying system daemon
    ${sysctl_check1}=        Execute Command       sudo sysctl -n net.ipv4.conf.all.log_martians
    Should Be Equal    ${sysctl_check1}    1
    ${sysctl_check2}=        Execute Command       sudo sysctl -n net.ipv4.conf.default.log_martians
    Should Be Equal    ${sysctl_check2}    1
