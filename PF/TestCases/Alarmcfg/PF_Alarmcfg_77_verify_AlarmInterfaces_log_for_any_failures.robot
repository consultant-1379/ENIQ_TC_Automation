*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Teardown    Close All Connections


*** Test Cases ***
verify AlarmInterfaces log for any failures
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${Alarm_folder}    ${latest_engine_file}
    ${faliure_logs}=    Opening the AlarmInterface latest file and checking for failure    ${latest_file}
    verify logs should not contain faliure   ${faliure_logs}