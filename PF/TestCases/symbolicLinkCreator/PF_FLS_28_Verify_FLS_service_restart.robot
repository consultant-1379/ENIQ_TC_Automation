*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verifying condition when fls is restart status
    Connect to server as a dcuser
    Verify status when fls is restarted