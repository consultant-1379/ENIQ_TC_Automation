*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_blade_rack_type.py


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***

check NaviCli latest version

    ${result}=    check_blade_rack_type    ${hostname}    ${username}    ${password}
    IF    "${result}"=="DL"
        ${output}=    Execute Command    rpm -qa | grep NaviCLI
        Should Be Empty    ${output}
		
    END