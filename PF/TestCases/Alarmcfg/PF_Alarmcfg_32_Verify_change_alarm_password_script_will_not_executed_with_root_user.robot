*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify change alarm password script will not get executed with root user 
    Open connection as root user
    ${cmd_output}=    Execute Command    /eniq/sw/bin/change_alarm_password.bsh
    Verify change alarm password script is not executed    ${cmd_output}    This script must be executed as dcuser
    [Teardown]    Test Teardown


*** Keywords ***
Test Teardown
    Close All Connections
