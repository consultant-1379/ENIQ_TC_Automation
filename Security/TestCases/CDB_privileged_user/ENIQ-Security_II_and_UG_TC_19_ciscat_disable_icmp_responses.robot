*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***

Test disable icmp responses is not set to 1 - Negative scenario

   ${file_existence}=        Execute Command          sudo test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/sysctl.conf /root/sysctl_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/net.ipv4.icmp_ignore_bogus_error_responses=1/net.ipv4.icmp_ignore_bogus_error_responses=0/g' /root/sysctl_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo cat /root/sysctl_backup.conf | grep  net.ipv4.icmp_ignore_bogus_error_responses
   Should Not Contain         ${negative_expected}              net.ipv4.icmp_ignore_bogus_error_responses=1
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sysctl_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test disable icmp responses is set to 1 - Positive scenario
    ${result}=      Execute Command       sudo cat /etc/sysctl.conf | grep net.ipv4.icmp_ignore_bogus_error_responses
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv4.icmp_ignore_bogus_error_responses=1
	Should Be Equal     ${sysctl_file_check}       net.ipv4.icmp_ignore_bogus_error_responses=1

Test disabling icmp responses is enforced in sysctl daemon - verifying system daemon
    ${sysctl_check1}=        Execute Command       sudo sysctl -n net.ipv4.icmp_ignore_bogus_error_responses
    Should Be Equal    ${sysctl_check1}    1

