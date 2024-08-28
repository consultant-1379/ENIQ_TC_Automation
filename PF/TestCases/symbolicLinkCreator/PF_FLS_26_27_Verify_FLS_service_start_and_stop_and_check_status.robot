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
Verifying condition when fls is Stop status
    Verify status when fls is stopped     
   
Verifying condition when fls is start status
    Verify status when fls is started