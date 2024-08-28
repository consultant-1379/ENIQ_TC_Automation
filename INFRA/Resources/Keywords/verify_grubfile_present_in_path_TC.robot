*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_grub_file
    ${output}=    Execute Command    ls  /boot/grub2 |grep grub.cfg
     [Return]    ${output}

