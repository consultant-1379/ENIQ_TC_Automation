*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary 10 seconds
Library            String
#ZAHAPBR
*** Test Cases ***

Test X11Forwarding in disable X11Forwarding is not set to no - Negative Scenario
   ${file_existence}=        Execute Command          test -f /etc/ssh/sshd_config && echo "Success" || echo "Fail"
   Should Be Equal           ${file_existence}        Success
   Log To Console            \nConfig file is present\n
   Execute Command           cp /etc/ssh/sshd_config /root/sshd_backup.conf
   Log To Console            \nSuccessfully backed up config file.\n
   Execute Command           sed -i 's/X11Forwarding no/X11Forwarding yes/g' /root/sshd_backup.conf
   Log To Console            \nNegative Scenario contents are written to backup file\n
   ${expected}                Execute Command         cat /etc/ssh/sshd_config | grep X11Forwarding | grep -v "^#.X11Forwarding"
   Should Contain         ${expected}             X11Forwarding no
   ${negative_expected}       Execute Command         cat /root/sshd_backup.conf | grep X11Forwarding | grep -v "^#.X11Forwarding"
   Should Not Contain         ${expected}             X11Forwarding yes
   Log To Console            \nNegative scenario tested successfully\n
   Execute Command           rm -rf /root/sshd_backup.conf
   Log To Console            \nBackup file deleted succssfully\n

Test X11Forwarding in disable X11Forwarding is set to no - Positive scenario
    ${result}=               Execute Command              cat /etc/ssh/sshd_config | grep X11Forwarding | grep -v "^#.X11Forwarding"
    ${get_lines_xfd}=        Get Lines Matching Regexp    ${result}      X11Forwarding no
    Should Be Equal    ${get_lines_xfd}                   X11Forwarding no

Test X11Forwarding is disabled on SSH daemon - Verifying system Daemon
    ${result}=        Execute Command       sshd -T | grep x11forwarding
    ${get_lines_xfd}=        Get Lines Matching Regexp    ${result}      x11forwarding no
    Should Be Equal     ${get_lines_xfd}       x11forwarding no
