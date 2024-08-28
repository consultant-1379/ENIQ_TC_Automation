*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkfirewall_status_TC.robot
Library    ../Scripts/verify_mws_is_node_hardened.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check if firewall active
    ${output}=    nh    ${mwshost}    ${mwsuser}    ${mwspwd}
    IF    "${output}"=="nh_applied"


        ${output_inactive}=    check_firewalld_status
        Should Contain    ${output_inactive}     Active: active (running)

    END

check if firewall enabled
    ${output}=    nh    ${mwshost}    ${mwsuser}    ${mwspwd}
    IF    "${output}"=="nh_applied"


        ${output_disabled}=    check_firewalld_status
        Should Contain    ${output_disabled}    ; enabled;

	END
	
	