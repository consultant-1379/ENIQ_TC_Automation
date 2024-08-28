*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verify the status of FLS service
    [Tags]    FLS
    Connect to server as a dcuser
    fls service check

*** Keywords ***
fls service check
    ${output}=    symboliclinkcreator_FLS_keywords.checking fls status    ${status}
    verifying the fls status    ${output}     ${cmpltd}
    verifying the fls status    ${output}    ${FLS}
    [Teardown]    Test teardown

Test teardown
    Close Connection

