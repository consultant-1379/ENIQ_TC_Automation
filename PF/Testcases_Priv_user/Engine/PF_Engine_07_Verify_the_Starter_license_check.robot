*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the Starter license check
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${output}=    Execute the command    ${license_manager_Network_IQ_Starter}
    Validate the output    ${output}    ${license_manager_expire_date}
    Verify license expire date    ${output}
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
  
  
    