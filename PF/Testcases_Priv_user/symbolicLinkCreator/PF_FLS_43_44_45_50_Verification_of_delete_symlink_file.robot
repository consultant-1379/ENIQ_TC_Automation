*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Setup    Open connection as root user    
Test Teardown    Close All Connections


*** Test Cases ***
 Verify for physical Delete_SymlinkFile is present in the EINQ-S 
    Verify deleteSymlink file should be present
    
Verify for error or exception in Delete_SymlinkFile 
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${latest_file}=    Getting latest file from the folder    ${symboliclink_folder}    ${latest_symboliclink_Delete_log_file}
    ${faliure_logs}=    Opening the DeleteSymlinkFile latest file and searching for failure    ${latest_file}
    verify logs should not contain faliure   ${faliure_logs}

Verify for symbolic link file is getting deleted which is not consumed by parsers
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Verifying if delete symlink log file contain zero older file