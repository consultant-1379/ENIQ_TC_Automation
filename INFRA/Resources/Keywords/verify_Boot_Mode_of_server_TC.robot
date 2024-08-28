*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_Boot_Mode
    ${output}=    Execute Command    [-d /sys/firmware/efi ] && echo UEFI || echo BIOS
     [Return]    ${output}
     

