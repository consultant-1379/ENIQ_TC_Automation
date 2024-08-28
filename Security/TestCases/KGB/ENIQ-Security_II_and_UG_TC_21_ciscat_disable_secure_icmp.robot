*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***

Test disable secure icmp parameters values are not 0 - Negative scenario
   ${file_existence}=        Execute Command          test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/net.ipv4.conf.all.secure_redirects=0/net.ipv4.conf.all.secure_redirects=1/g; s/net.ipv4.conf.default.secure_redirects=0/net.ipv4.conf.default.secure_redirects=1/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         grep  -e "net.ipv4.conf.all.secure_redirects" -e "net.ipv4.conf.default.secure_redirects" /root/sysctl_backup.conf 
   Should Not Contain         ${negative_expected}              net.ipv4.conf.all.secure_redirects=0       net.ipv4.conf.default.secure_redirects=0
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable secure icmp parameters values are 0 - Positive scenario
    ${result}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.all.secure_redirects
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv4.conf.all.secure_redirects=0
	Should Be Equal     ${sysctl_file_check}       net.ipv4.conf.all.secure_redirects=0

    ${result1}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.default.secure_redirects
	${sysctl_file_check1}=        Get Lines Matching Regexp    ${result1}      net.ipv4.conf.default.secure_redirects=0
	Should Be Equal     ${sysctl_file_check1}       net.ipv4.conf.default.secure_redirects=0


Test disabling secure icmp parameters is enforced in sysctl daemon - verifying system daemon

    ${sysctl_check1}=        Execute Command       sysctl -n net.ipv4.conf.all.secure_redirects
    Should Be Equal    ${sysctl_check1}    0
    ${sysctl_check2}=        Execute Command       sysctl -n net.ipv4.conf.default.secure_redirects
    Should Be Equal    ${sysctl_check2}    0
 
