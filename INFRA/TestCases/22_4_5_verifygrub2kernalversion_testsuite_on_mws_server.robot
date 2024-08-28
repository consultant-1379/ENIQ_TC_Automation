*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py



Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check for kernel version
    ${output}=    Execute Command    cat /boot/grub2/grub.cfg |grep kernel
    ${output1}=    Execute Command    uname -r
    ${output2}=    Should Contain     ${output}     ${output1}


