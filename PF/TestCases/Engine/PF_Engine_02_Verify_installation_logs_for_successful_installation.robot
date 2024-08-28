*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify installation logs for successful installation
    Connect to server as a dcuser 
    Go to the folder    ${platform_installer}
    ${latest_file}=    Get latest file from directory    engine*
    #Negative Scenario 0 arg, like error, warning, exception, failed
    #Positive Scenario 1 arg, like Success, created, passed
    ${output}=    Validate the log file for   ${successfully_installation}    ${latest_file}    1
    Verify the log file containing    ${output}    @{successful_msg}
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
