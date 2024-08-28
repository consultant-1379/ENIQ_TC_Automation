*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify the incorrect command for engine -e restart
    Connect to server as a dcuser
    ${engine_restart_status}=    Execute the command    ${engine_restart}
    Sleep    25s  
    Verify the error msg    ${engine_restart_status}    Invalid command entered: restart
    Verify the error msg    ${engine_restart_status}    Execute failed
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections 