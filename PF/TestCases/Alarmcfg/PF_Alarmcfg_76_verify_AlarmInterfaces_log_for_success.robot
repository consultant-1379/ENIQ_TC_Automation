*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Teardown    Close All Connections


*** Test Cases ***
verify AlarmInterfaces log for Success
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${Alarm_folder}    ${latest_engine_file}
    ${Success_logs}=    Opening the Alarm latest file and checking for Success message  ${latest_file}
    verify logs should contain success message    ${Success_logs}