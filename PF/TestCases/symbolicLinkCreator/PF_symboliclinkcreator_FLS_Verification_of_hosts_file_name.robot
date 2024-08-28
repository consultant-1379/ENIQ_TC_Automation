*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verification of /etc/hosts with INGRESS IP and hostname
    [Tags]    FLS
    Connect to server as a dcuser
    Verifying hosts file is with ENM alias INGRESS IP and hostname
    
*** Keywords ***
Verifying hosts file is with ENM alias INGRESS IP and hostname
    symboliclinkcreator_FLS_keywords.Execute the Command    ${installer path}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls}
    ${output}=    symboliclinkcreator_FLS_keywords.Display the contents in the file     ${services-4}
    verify the output contains CENM INGRESS IP and ENM hostname    ${output}
    [Teardown]    Test teardown

Test teardown
    Close Connection