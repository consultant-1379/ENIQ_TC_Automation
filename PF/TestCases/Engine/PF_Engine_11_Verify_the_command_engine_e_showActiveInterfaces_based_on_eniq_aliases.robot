*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the command engine -e showActiveInterfaces based on the eniq aliases if multiple ENM connected
    Connect to server as a dcuser
    ${cmd_output}=   Execute the commands    engine -e showActiveInterfaces
    Verify 'Getting Active Interfaces' is displayed    ${cmd_output}    
    Verify Active Interface is listed
    @{enm_list}=    Get the number of ENM Connections
    Verify the Active Interfaces for multiple ENM connections    @{enm_list}
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections




