*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Engine.robot



*** Test Cases ***
Verify the Check for insanity using CLI
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${current_date}=    Get current date in yyyy.mm.dd result_format
    ${grepError_results}=    Execute Command    cat /eniq/log/sw_log/engine/engine-${current_date}.log | grep -i INSANE
    Verify the logs should be Empty    ${grepError_results}
    [Teardown]    Test Teardown

*** Keywords ***
Test Teardown
    Close All Connections    