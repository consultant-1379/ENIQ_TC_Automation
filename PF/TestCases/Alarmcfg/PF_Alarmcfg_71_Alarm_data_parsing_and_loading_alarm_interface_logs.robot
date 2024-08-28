*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
 Verify if Alarmcfg log has any error
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${Alarmcfg_folder}    ${latest_Alarmcfg_file}   
    ${faliure_logs}=   Opening the AlarmCfg latest file and searching for failure    ${latest_file}  
    verify logs should not contain faliure    ${faliure_logs}