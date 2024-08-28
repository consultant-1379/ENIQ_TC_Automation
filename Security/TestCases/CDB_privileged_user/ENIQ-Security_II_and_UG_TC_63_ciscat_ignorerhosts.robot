*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***

Test IgnoreRhosts parameter is not set to yes - Negative scenario
   ${file_existence}=        Execute Command          sudo test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           sudo cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/IgnoreRhosts yes/IgnoreRhosts no/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         sudo cat /root/sshd_backup.conf | grep IgnoreRhosts
   Should Not Contain         ${negative_expected}             X11Forwarding no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test IgnoreRhosts parameter is yes - positive scenario
    ${result}=        Execute Command        sudo cat /etc/ssh/sshd_config | grep IgnoreRhosts
    Should Be Equal     ${result}            IgnoreRhosts yes
 
Test IgnoreRhosts is enabled on SSH daemon - Checking in system daemon
    ${result}=        Execute Command       sudo sshd -T | grep ignorerhosts
    ${get_lines_irh}=        Get Lines Matching Regexp    ${result}      ignorerhosts yes
    Should Be Equal     ${get_lines_irh}       ignorerhosts yes
 