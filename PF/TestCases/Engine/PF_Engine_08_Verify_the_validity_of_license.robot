*** Settings ***
Library    SSHLibrary
Library    DateTime
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot



*** Test Cases ***
Verify the validity of license
    Connect to server as a dcuser	
    ${output}=    Execute the command    ${license_manager_IQ_Eniq_Capacity}
    Validate the output    ${output}    ${license_manager_expire_date}
    Verify license expire date    ${output}
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections


    