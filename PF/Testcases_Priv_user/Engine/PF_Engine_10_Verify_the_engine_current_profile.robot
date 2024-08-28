*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify the engine current profile
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${output}=    Execute the command    engine -e getCurrentProfile
    Validate the output    ${output}    Normal
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
    
    