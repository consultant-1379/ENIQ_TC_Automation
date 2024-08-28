*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the status of license server and License manager from command line
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Verify the status of license server and License manager
    