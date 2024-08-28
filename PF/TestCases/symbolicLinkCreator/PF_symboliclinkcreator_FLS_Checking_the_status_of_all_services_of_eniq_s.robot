*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Check the status of all services of ENIQ-S
    [Tags]    FLS
    Connect to server as a dcuser
    Verification of the status of all services of ENIQ-S 
    
*** Keywords ***
Verification of the status of all services of ENIQ-S
    ${output}=    symboliclinkcreator_FLS_keywords.Execute the Command    ${service check}
    verify the active and inactive services    ${output}    ${list_of_active_services_fls}    ${list_of_inactive_services_fls}
    [Teardown]    Test teardown

Test teardown
    Close Connection





