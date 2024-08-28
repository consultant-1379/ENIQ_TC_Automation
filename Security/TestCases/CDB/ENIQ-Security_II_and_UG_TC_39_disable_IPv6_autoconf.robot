*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
#ZAHAPBR
*** Test Cases ***
Test disable Ipv6 autoconf parameter are not set to 0 - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/net.ipv6.conf.default.autoconf=0/net.ipv6.conf.default.autoconf=1/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sysctl_backup.conf | grep  net.ipv6.conf.default.autoconf
   Should Not Contain         ${negative_expected}              net.ipv6.conf.default.autoconf=0
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable Ipv6 autoconf parameter is set to 0 - positive scenario
    ${result}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv6.conf.default.autoconf
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv6.conf.default.autoconf=0
	Should Be Equal     ${sysctl_file_check}       net.ipv6.conf.default.autoconf=0

Test disabling Ipv6 autoconf parameter is enforced in sysctl daemon - Verifying system daemon
    ${sysctl_check1}=        Execute Command       sysctl -n net.ipv6.conf.default.autoconf
    Should Be Equal    ${sysctl_check1}    0

