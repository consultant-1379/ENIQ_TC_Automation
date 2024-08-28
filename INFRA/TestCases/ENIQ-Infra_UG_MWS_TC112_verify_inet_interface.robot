*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to mws


*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Check bond Interface
    ${output}=    Execute Command    dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5
    Log To Console    ${output}
    IF    "${output}"=="Gen10 Plus"
        ${output1}=    Execute Command    ip addr show|grep bond
        Should Contain    ${output1}    inet

    END

