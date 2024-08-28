*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***

Test GSSAPIAuthentication parameter is not set to no - Negative scenario
   ${file_existence}=        Execute Command          sudo test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sudo sed -i 's/GSSAPIAuthentication no/GSSAPIAuthentication yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep GSSAPIAuthentication
   Should Not Contain         ${negative_expected}              GSSAPIAuthentication no
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           sudo rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test SSAPIAuthentication parameter is set to no - Positive scenario
    ${result}=          Execute Command         sudo cat /etc/ssh/sshd_config | grep GSSAPIAuthentication
    Should Be Equal     ${result}               GSSAPIAuthentication no
    
Test SSAPIAuthentication parameter is set to no in SSH daemon - Verifying system daemon
    ${result}=               Execute Command              sudo sshd -T | grep gssapiauthentication
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      gssapiauthentication no
    Should Be Equal          ${get_lines_mat}             gssapiauthentication no
