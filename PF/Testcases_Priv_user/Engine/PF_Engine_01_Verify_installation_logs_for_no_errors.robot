*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify installation logs for no errors
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Go to the folder    ${platform_installer}
    ${latest_file}=    Get latest file from directory    engine*
    #Negative Scenario 0 arg, like error, warning, exception, failed
    #Positive Scenario 1 arg, like Success, created, passed
    Validate the log file for    ${no_error_warning_exception_failed}    ${latest_file}    0
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections