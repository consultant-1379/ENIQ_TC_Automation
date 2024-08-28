*** Settings ***
Documentation    Testing Symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Teardown    Close All Connections

*** Test Cases ***
Check for physical Symboliclinkcreator common file is presence in the EINQ-S and Check for error or exception in Symboliclinkcreator common file
    Open connection as root user
    ${latest_symboliclinkcreator}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator/ ; ls -Art symboliclinkcreator-*| tail -1
    Verify file is present    ${latest_symboliclinkcreator}

