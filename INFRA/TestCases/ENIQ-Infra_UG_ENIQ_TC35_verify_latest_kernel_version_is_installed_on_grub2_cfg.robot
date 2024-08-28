*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***

Check for Boot Mode
    ${output}=    Execute Command    sudo dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5
    Log To Console    ${output}
    IF    "${output}"=="Gen10 Plus"   
        ${etc_kernel}=    Execute Command    sudo cat /etc/grub2-efi.cfg|grep kernel
        ${mws_kernel}=    Execute Command    uname -r
        Should Contain    ${etc_kernel}    ${mws_kernel} 
    ELSE
        ${etc_kernel}=    Execute Command    sudo cat /etc/grub2.cfg|grep kernel
        ${mws_kernel}=    Execute Command    uname -r
        Should Contain    ${etc_kernel}    ${mws_kernel} 
	
    END
