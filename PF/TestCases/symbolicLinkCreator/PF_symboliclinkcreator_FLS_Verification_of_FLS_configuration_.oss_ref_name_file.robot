*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases *** 
Verification of FLS configuration file ".oss_ref_name_file"
    [Tags]    FLS
    Connect to server as a dcuser
    Verification of .oss_ref_name_file is with ENM alias and NAS IP address
    
*** Keywords ***
 Verification of .oss_ref_name_file is with ENM alias and NAS IP address
    ${oss_file}=    Execute Command    cat /eniq/installation/config/fls_conf
    ${oss_ref_name_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file
    Verify the msg    ${oss_ref_name_file}    ${oss_file}
    ${get_eniq_oss_line}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file | grep -i ${oss_file}
    ${nas_ip_address}=    Execute Command    cat /eniq/sw/conf/enmserverdetail | awk '{print $1}'
    Verify the msg   ${get_eniq_oss_line}    ${nas_ip_address}  
    [Teardown]    Test teardown


Test teardown
    Close Connection
    
