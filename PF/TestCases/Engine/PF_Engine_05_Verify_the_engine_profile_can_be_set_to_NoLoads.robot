*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases *** 
Verify the engine profile can be set to NoLoads
    Connect to server as a dcuser	
    ${output}=    Execute the command    engine -e changeProfile NoLoads
    Validate the output    ${output}    Change profile requested successfully
    Validate the output    ${output}    ${profile_noloads}

    ${output}=    Execute the command    engine -e changeProfile Normal
    Validate the output    ${output}    Change profile requested successfully
    Validate the output    ${output}    ${profile_normal}
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
