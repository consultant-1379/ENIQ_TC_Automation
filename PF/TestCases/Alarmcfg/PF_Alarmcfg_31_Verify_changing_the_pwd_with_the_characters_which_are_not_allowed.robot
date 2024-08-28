*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Library     ../../Scripts/random_password_noncomplaint_generation.py
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify changing of password with not allowed character
    Connect to server as a dcuser
    ${output_of_changing_password_scripts}=    Executing change password script and providing noncomplaint random genrated password
    Verify password is not changed    ${output_of_changing_password_scripts}    
    
    
    
   