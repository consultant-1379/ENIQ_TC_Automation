*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases *** 
Verify FLS configuration file service_names
    [Tags]    FLS
    Connect to server as a dcuser
    verify service_names file is with CENM INGRESS IP and alias address

*** Keywords ***
verify service_names file is with CENM INGRESS IP and alias address
    symboliclinkcreator_FLS_keywords.Execute the Command   cd ${installer path}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls}
    ${output}=    symboliclinkcreator_FLS_keywords.Display the contents in the file     cat ${service-3}
    ${oss_ref_contents}=    symboliclinkcreator_FLS_keywords.Display the contents in the file   cat ${Enm-2} 
    ${eniqAliasNames}=    get the enm alias names     ${oss_ref_contents}
    verify the output contains CENM INGRESS IP address    ${output}    ${eniqAliasNames}
    [Teardown]    Test teardown

Test teardown
    Close Connection
    