*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the incorrect command for engine -e start
    Connect to server as a dcuser
    ${enginestart_status}=    Execute the command    ${engine_start}   
    Verify the error msg    ${enginestart_status}    Invalid command entered: start
    Verify the error msg    ${enginestart_status}    Execute failed
    Execute the command    ${Engine_logs_path}
    ${engine_stop_log}=    Grep message from file    error    stop_engine_*.log
    ${engine_stop_log}=    Grep message from file    execption    stop_engine_*.log
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections       