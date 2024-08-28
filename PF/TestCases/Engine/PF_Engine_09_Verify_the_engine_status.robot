*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify the engine status
    Connect to server as a dcuser
    ${output}=    Execute the command    engine status
    Validate the output    ${output}    Current Profile: Normal
    Validate the output    ${output}    engine is running OK
    Validate the output    ${output}    lwp helper is running
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
    
    