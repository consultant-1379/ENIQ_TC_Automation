*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Library     ../../Scripts/random_password_complaint_generation.py
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify changing of password with allowed character 
    Connect to server as a dcuser
    ${output_of_changing_password_script}=    Executing password change script and providing complaint random generated password
    ${check_password_is_complaint}=    Verify password is changed    ${output_of_changing_password_script}
    changing password to old password    ${check_password_is_complaint}