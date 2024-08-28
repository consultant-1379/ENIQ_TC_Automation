
*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Library    ../Scripts/check_blade_rack_type.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
Ensure VNX keys are available in ENIQ server for passwordless connection

    ${output}=    check_blade_rack_type    ${hostname}    ${username}    ${password}
    IF    "${output}"=="BL"
        ${op}=    Execute Command     cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE"
        IF    "${op}"=="SAN_DEVICE=vnx"
            ${conf}=    Execute Command    ls -lrt /ericsson/storage/san/plugins/vnx/etc | grep 'clariion.conf'
            Should Not Be Empty    ${conf}
        END
    END
