*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
 Verify for physical start_fls log file is present in the ENIQ-S 
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${symboliclink_folder}    ${latest_symboliclink_start_log_file}
    ${faliure_logs}=    Opening the fls latest file and searching for failure    ${latest_file}
    verify logs should not contain faliure   ${faliure_logs}