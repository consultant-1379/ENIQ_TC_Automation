*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to eniq
Test Teardown    Close All Connections
*** Keywords ***
Login to eniq
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1
*** Test Cases ***
Check for kernel version in grub2 cfg
    ${output}=    Execute Command    dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5
    Log To Console    ${output}
    IF    "${output}"=="Gen10 Plus"
        ${etc_kernel}=    Execute Command    cat /etc/grub2-efi.cfg|grep kernel
        ${mws_kernel}=    Execute Command    uname -r
        Should Contain    ${etc_kernel}    ${mws_kernel}
    ELSE
        ${etc_kernel}=    Execute Command    cat /etc/grub2.cfg|grep kernel
        ${mws_kernel}=    Execute Command    uname -r
        Should Contain    ${etc_kernel}    ${mws_kernel}

    END