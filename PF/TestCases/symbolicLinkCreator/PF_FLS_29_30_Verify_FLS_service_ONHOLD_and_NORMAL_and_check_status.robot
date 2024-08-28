*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Setup   Connect to server as a dcuser
Test Teardown    Close All Connections


*** Test Cases ***
Verifying condition when fls is OnHold status
    Changing fls status as OnHold 
    Verifying fls status changed to OnHold and fls is running  
   
Verifying condition when fls is normal status
    Changing fls status as Normal 
    Verifying fls status changed to Normal and fls is running