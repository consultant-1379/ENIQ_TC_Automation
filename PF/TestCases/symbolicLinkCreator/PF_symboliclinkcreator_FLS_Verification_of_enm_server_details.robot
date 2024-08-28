*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verifying the enm server details
    [Tags]    FLS
    Connect to server as a dcuser
    Verify enmserverdetail file is with CENM INGRESS IP address
    
*** Keywords ***
Verify enmserverdetail file is with cENM INGRESS IP address
    ${oss_file}=    Execute Command    cat /eniq/installation/config/fls_conf
    ${oss_ref_name_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file
    Verify the msg    ${oss_ref_name_file}    ${oss_file}
    ${get_eniq_oss_line}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${oss_file}
    ${nas_ip_address}=    Execute Command    cat /eniq/sw/conf/enmserverdetail | awk '{print $1}'
    Verify the msg   ${get_eniq_oss_line}    ${nas_ip_address}

Test teardown
    Close Connection

    