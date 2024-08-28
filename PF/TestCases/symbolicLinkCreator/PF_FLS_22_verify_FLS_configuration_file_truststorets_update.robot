*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Library    DateTime
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
FLS configuration file truststore.ts update
    Connect to server as a dcuser
    Set Client Configuration    prompt=ieatrcx    timeout=10s
    Getting the password of truststore file
    Verify the validity of fls license in truststore file