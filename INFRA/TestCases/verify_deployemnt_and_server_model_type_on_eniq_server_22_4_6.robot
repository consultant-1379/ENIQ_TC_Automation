***Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1




*** Test Cases ***
check for deployment
    ${output}=    Execute Command    dmidecode -t chassis | grep -w "Type" | awk '{print $2}'
    Should Be Equal     ${output}    Blade

check for server type
    ${output1}=    Execute Command    dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5 
    Should Be Equal     ${output1}    Gen10 Plus


