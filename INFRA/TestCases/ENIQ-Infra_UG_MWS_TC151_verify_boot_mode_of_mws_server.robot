***Settings ***

Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1




*** Test Cases ***
Check for Boot Mode
    ${output}=    Execute Command    [-d /sys/firmware/efi ] && echo UEFI || echo BIOS
    Log To Console    ${output}
    IF    "${output}"=="BIOS"


        ${output1}=    Execute Command    ls  /boot/grub2 |grep grub.cfg
        Should Not Be Empty    ${output1}
        
        

    ELSE


        ${output4}=    Execute Command     ls /boot/efi/EFI/redhat/|grep grub.cfg
        Should Not Be Empty    ${output4}
    END

