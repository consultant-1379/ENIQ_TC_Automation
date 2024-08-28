
*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Library    ../Scripts/check_rack_type.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
Ensure Unity keys are available in ENIQ server for passwordless connection

    ${output}=    check_rack_type    ${hostname}    ${username}    ${password}
    IF    "${output}"=="BL"
        ${conf}=    Execute Command     ls -lrt /ericsson/storage/san/plugins/unity/etc/ | grep "unity.conf"
        Should Not Be Empty    ${conf}
    ELSE IF    "${output}"=="Multi_Rack"
        ${conf}=    Execute Command     ls -lrt /ericsson/storage/san/plugins/unity/etc/ | grep "unity.conf"
        Should Not Be Empty    ${conf}
    END
