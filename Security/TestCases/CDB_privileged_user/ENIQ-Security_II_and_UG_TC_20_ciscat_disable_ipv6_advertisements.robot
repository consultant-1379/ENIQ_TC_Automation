*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
*** Variables ***
@{list_var}        net.ipv6.conf.all.accept_ra=0    net.ipv6.conf.default.accept_ra=0

*** Test Cases ***
 Test disable ipv6 advertisements parameters values are not 1 - Negative scenario
   ${file_existence}=        Execute Command          sudo test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/net.ipv6.conf.all.accept_ra=0/net.ipv6.conf.all.accept_ra=1/g; s/net.ipv6.conf.default.accept_ra=0/net.ipv6.conf.default.accept_ra=1/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo grep  -e "net.ipv6.conf.all.accept_ra" -e "net.ipv6.conf.default.accept_ra" /root/sysctl_backup.conf 
   Should Not Contain         ${negative_expected}              net.ipv6.conf.all.accept_ra=0        net.ipv6.conf.default.accept_ra=0
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable ipv6 advertisements parameters values are 0 - positive scenario
    ${result}=      Execute Command       sudo cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_ra
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv6.conf.all.accept_ra=0
	Should Be Equal     ${sysctl_file_check}       net.ipv6.conf.all.accept_ra=0

    ${result1}=      Execute Command       sudo cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_ra
	${sysctl_file_check1}=        Get Lines Matching Regexp    ${result1}      net.ipv6.conf.default.accept_ra=0
	Should Be Equal     ${sysctl_file_check1}       net.ipv6.conf.default.accept_ra=0

Test disabling Ipv6 advertisements is enforced in sysctl daemon - verifying system daemon
    ${sysctl_check1}=        Execute Command       sudo sysctl -n net.ipv6.conf.all.accept_ra
    Should Be Equal    ${sysctl_check1}    0
    ${sysctl_check2}=        Execute Command       sudo sysctl -n net.ipv6.conf.default.accept_ra
    Should Be Equal    ${sysctl_check2}    0
