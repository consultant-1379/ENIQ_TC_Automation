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
check for san type
    ${output}=    Execute Command    cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE" | awk -F"=" '{print $2}'
    Should Be Equal     ${output}    unity    OR    unity_XT
check for Unisphere
    ${output1}=    Execute Command    rpm -qa|grep UnisphereCLI
    Should Not Be Empty    ${output1}


