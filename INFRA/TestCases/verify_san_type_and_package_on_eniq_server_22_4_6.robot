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
    Should Be Equal     ${output}    vnx
check for HostAgent
    ${output1}=    Execute Command    rpm -qa|grep HostAgent
    Should Not Be Empty    ${output1}
check for NaviCLI
    ${output2}=    Execute Command    rpm -qa|grep NaviCLI
    Should Not Be Empty    ${output2}
check for InitTool
    ${output3}=    Execute Command    rpm -qa|grep InitTool
    Should Not Be Empty    ${output3}

    
