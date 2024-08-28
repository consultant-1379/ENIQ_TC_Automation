*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verification of the .ser files generation
    [Tags]    FLS
    Connect to server as a dcuser
    Verifying whether the .ser files get generated in the following path

*** Keywords ***
Verifying whether the .ser files get generated in the following path
    symboliclinkcreator_FLS_keywords.Execute the Command  cd ${conf}
    ${file_list}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls-lrt}
    verify the file is present in the file list   ${file_list}    ${.ser}
    ${output}=    symboliclinkcreator_FLS_keywords.List the properties of the file  ls -lah ${.ser}
    verify the .ser file size is not zero   ${output}
    [Teardown]    Test teardown

Test teardown
    Close Connection






