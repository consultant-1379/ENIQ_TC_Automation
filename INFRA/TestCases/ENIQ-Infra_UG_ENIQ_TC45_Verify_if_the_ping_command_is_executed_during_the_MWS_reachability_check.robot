*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/verify_ping_command.py
Test Setup    Login to eniq
Test Teardown    Close All Connections
*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1
*** Test Cases ***
Verify if the ping/ping6 command is executed during the MWS reachability check
    ${output}=    Execute Command    cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep 'CLIENT_DEPLOY_TYPE'
    ${output1}=    Execute command    cat /etc/hosts | grep -w "MWS" | awk '{print $2}'
    Log To Console    ${output1}
    ${value}=    ping_cmd_check    ${eniq_upg_hostname}     ${eniq_upg_username}    ${eniq_upg_password}    ${output1}
    Should Contain    ${value}    True

	
