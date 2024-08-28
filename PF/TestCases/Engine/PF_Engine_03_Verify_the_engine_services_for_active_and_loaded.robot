*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the engine services for active and loaded
    Open connection as root user
    ${output}=    Execute the command    ${engine_service_status}
    Validate the output    ${output}    Loaded: loaded
    Validate the output    ${output}    active (running)
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
    
    