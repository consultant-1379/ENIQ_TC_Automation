*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
 Verify for physical start_fls log file is present in the ENIQ-S 
    Open connection as root user
    ${checking_file}    Execute Command    ls /eniq/log/sw_log/symboliclinkcreator/ | grep -i start_fls 
    Should Not Be Empty    ${checking_file}
