*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verification of fls_conf file
    [Tags]    FLS
    Connect to server as a dcuser
    Verification of fls_conf file is with ENM
        
*** Keywords ***
Verification of fls_conf file is with ENM
    ${fls_conffile}=    Execute Command    cat /eniq/installation/config/fls_conf
    Verify the enm alias name in server    ${fls_conffile}    ^eniq_oss_\\d+$
    [Teardown]    Test teardown

Test teardown
    Close Connection