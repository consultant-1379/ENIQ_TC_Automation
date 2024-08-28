*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to mws
Test Teardown    Close All Connections
*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1
*** Test Cases ***
check if auditd.service is active
    ${output_JUMP1}=    Execute Command    systemctl status auditd.service|grep active
    Should Not Be Empty    ${output_JUMP1}
check if autofs.service is active
    ${output_JUMP2}=    Execute Command    systemctl status autofs.service|grep active
    Should Not Be Empty    ${output_JUMP2}
check if dhcpd.service is active
    ${output_JUMP3}=    Execute Command    systemctl status dhcpd.service|grep active
    Should Not Be Empty    ${output_JUMP3}
check if lvm2-lvmetad.service is active
    ${output_JUMP4}=    Execute Command    systemctl status lvm2-lvmetad.service|grep active
    Should Not Be Empty    ${output_JUMP4}
check if nfs-idmapd.service is active
    ${output_JUMP5}=    Execute Command    systemctl status nfs-idmapd.service|grep active
    Should Not Be Empty    ${output_JUMP5}
check if nfs-mountd.service is active
    ${output_JUMP6}=    Execute Command    systemctl status nfs-mountd.service|grep active
    Should Not Be Empty    ${output_JUMP6}
check if xinetd.service is active
    ${output_JUMP7}=    Execute Command    systemctl status xinetd.service|grep active
    Should Not Be Empty    ${output_JUMP7}
check if sshd.service is active
    ${output_JUMP8}=    Execute Command    systemctl status sshd.service|grep active
    Should Not Be Empty    ${output_JUMP8}
check if rpc-statd.service is active
    ${output_JUMP9}=    Execute Command    systemctl status rpc-statd.service|grep active
    Should Not Be Empty    ${output_JUMP9}
check if rpcbind.service is active
    ${output_JUMP10}=    Execute Command    systemctl status rpcbind.service|grep active
    Should Not Be Empty    ${output_JUMP10}

