*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource   ../../Resources/Keywords/Variables.robot
Resource   ../../Resources/Keywords/Installer.robot

*** Test Cases ***
verify node hardening to the server
    [Tags]    Installer
    Open connection as root user
    verifying node hardening to the server
    #It will work only in Vapp servers 

***keywords***
verifying node hardening to the server 
    ${Features}=    Execute Command    ${Linux_media_folder}
    ${mws_path}=    Execute Command    ${Linux_media_folder_02}${Features};ls -Art | grep -i 22.2 | tail -1
    Execute the command    cd /${mws_path}/om_linux/security/ERICnodehardening-R9D02.rpm
    Execute the Command    ${grep_node_hardening}
    Execute the command    ${node_hardening}
    Grant permission    y
    ${node_hardening_status}=    Read    delay=200s
    verifying node hardening status    ${node_hardening_status}     The server will reboot now   
    [Teardown]    Test teardown

Test teardown
    Close Connection