*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            String

*** Test Cases ***
Test firewall status
    ${result}=      Execute Command       sudo systemctl status firewalld | grep -i Active | cut -d':' -f 2 | cut -d ' ' -f 2
    ${result1}=      Execute Command       sudo systemctl status firewalld | sed -n '/Loaded:/p' | cut -d ';' -f 2 | cut -d ' ' -f 2
    ${firewall_check}=        Get Lines Matching Regexp    ${result}    active
    ${firewall_check_1}=        Get Lines Matching Regexp    ${result1}    enabled
    Should Be Equal     ${firewall_check}       active
    Should Be Equal     ${firewall_check_1}       enabled

Test ICMP block check
    ${result1}=      Execute Command       sudo firewall-cmd --query-icmp-block=redirect
    ${result2}=      Execute Command       sudo firewall-cmd --query-icmp-block=timestamp-reply
    ${result3}=      Execute Command       sudo firewall-cmd --query-icmp-block=router-solicitation
    ${result4}=      Execute Command       sudo firewall-cmd --query-icmp-block=router-advertisement
    ${icmp_chk1}=        Get Lines Matching Regexp    ${result1}     yes
    ${icmp_chk2}=        Get Lines Matching Regexp    ${result2}     yes
    ${icmp_chk3}=        Get Lines Matching Regexp    ${result3}     yes
    ${icmp_chk4}=        Get Lines Matching Regexp    ${result4}     yes
    Should Be Equal     ${icmp_chk1}    yes
    Should Be Equal     ${icmp_chk2}    yes
    Should Be Equal     ${icmp_chk3}    yes
    Should Be Equal     ${icmp_chk4}    yes

Test ICMP ECHO not ignored
    ${result}=  Execute Command     sudo cat /etc/sysctl.conf | grep net.ipv4.icmp_echo_ignore_all
    ${icmp_echo_chk}=        Get Lines Matching Regexp    ${result}     net.ipv4.icmp_echo_ignore_all = 0
    Should Be Equal     ${icmp_echo_chk}       net.ipv4.icmp_echo_ignore_all = 0

Test ICMP ECHO not ignored is configured in sysctl daemon
    ${result}=  Execute Command     sudo sysctl -n net.ipv6.conf.all.accept_ra
    Should Be Equal     ${result}       0
