*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test vsftpd not present in hosts deny file
    ${cmd}=                  Execute Command       sudo sed -i 's/ALL/NO/g' /etc/hosts.deny
    ${result}=               Execute Command   sudo cat /etc/hosts.deny | grep vsftpd
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      vsftpd: NO
    Should Be Equal          ${result}       vsftpd: NO
    ${cmd_1}=                Execute Command       sudo sed -i 's/NO/ALL/g' /etc/hosts.deny

Test hosts allow file is present
    ${result}=               Execute Command   sudo find /etc/hosts.allow
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      /etc/hosts.allow
    Should Be Equal          ${result}       /etc/hosts.allow

Test hosts deny file is present
    ${result}=               Execute Command   sudo find /etc/hosts.deny
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      /etc/hosts.deny
    Should Be Equal          ${result}       /etc/hosts.deny

Test vsftpd present in hosts deny file
    ${result}=               Execute Command   sudo cat /etc/hosts.deny | grep vsftpd
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}      vsftpd: ALL
    Should Be Equal          ${result}       vsftpd: ALL




