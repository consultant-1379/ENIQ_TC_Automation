*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the condition when Starter License get expired.
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Comparing expiring date with current date of starter license
    Verify if starter license is expired or not 
    
    