*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the command engine -e loggingStatus
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${logging_status}=    Execute the command    engine -e loggingStatus
    Sleep    30s
    Verify the msg    ${logging_status}    Querying logging status   
    Verify the msg    ${logging_status}    Logging status printed succesfully
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
