*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot

*** Test Cases ***
Verify the command for engine -e status
    Connect to server as a dcuser
    ${engine_status}=    Execute Command    /eniq/sw/bin/engine -e status 
    Verify the msg    ${engine_status}    Execution Profile
    Verify the msg    ${engine_status}    Completed successfully
    [Teardown]    Test Teardown
    
*** Keywords ***
Test Teardown
    Close All Connections          