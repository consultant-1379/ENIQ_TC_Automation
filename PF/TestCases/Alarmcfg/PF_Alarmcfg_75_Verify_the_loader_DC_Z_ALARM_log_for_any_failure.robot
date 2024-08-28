*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the loader_DC_Z_ALARM log for Failure
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${DC_Z_Log_path}    ${latest_engine_file}
    ${failure_logs}=    Opening the loader_DC_Z_ALARM latest file and checking for failure message  ${latest_file}
    verify logs should not contain faliure    ${failure_logs}