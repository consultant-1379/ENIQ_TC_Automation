*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_blade_rack_type.py
Test Setup    Login to ENIQ
Test Teardown    Close All Connections
*** Keywords ***
Login to ENIQ
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1
*** Test Cases ***
Verify if /var/log size is 30G
    ${output}=    check_blade_rack_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    IF    "${output}"=="DL"
        ${output1}=     Execute Command     df -h |grep -w /var/log |awk '{print $2}'
        Log To Console    ${output1}
        Should Contain     ${output1}     30G
    END	      
	
