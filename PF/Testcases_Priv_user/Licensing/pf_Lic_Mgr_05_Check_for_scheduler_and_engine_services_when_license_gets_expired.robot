*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Check for license manager and scheduler services when license gets expired
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Verify status of Scheduler
