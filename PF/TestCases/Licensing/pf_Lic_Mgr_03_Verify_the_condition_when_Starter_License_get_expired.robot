*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the condition when Starter License get expired.
    Connect to server as a dcuser 
    Comparing expiring date with current date of starter license
    Verify if starter license is expired or not 
    
    