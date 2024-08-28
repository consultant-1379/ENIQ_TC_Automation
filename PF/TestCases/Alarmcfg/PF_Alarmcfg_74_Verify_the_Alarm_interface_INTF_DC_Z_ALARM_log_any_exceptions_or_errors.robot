*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the Alarm interface INTF_DC_Z_ALARM log any exceptions or errors
    Connect to server as a dcuser
    ${latest_alarm_interface_log}=    Getting latest file from the folder    ${alarm_interface_path}    ${latest_engine_file}
    ${failure_logs}    Opening the AlarmInterface latest file and checking for failure message    ${latest_alarm_interface_log}
    verify logs should not contain faliure    ${failure_logs}  