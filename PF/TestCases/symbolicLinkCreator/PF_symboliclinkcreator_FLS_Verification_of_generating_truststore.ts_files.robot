*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verification of Truststore.ts files created in following path
    [Tags]    FLS
    Connect to server as a dcuser
    verifying whether truststore.ts files should be displayed

*** Keywords ***
verifying whether truststore.ts files should be displayed
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${security_path}
    ${file_list}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ${ls-lrt}
    verify the file is present in the file list   ${file_list}    ${file}
    symboliclinkcreator_FLS_keywords.List the files in the folder    ${lrth}
    ${output}=    symboliclinkcreator_FLS_keywords.List the files in the folder    ls -lah ${file}
    verify the truststore.ts file size is not zero    ${output}
    [Teardown]    Test teardown

Test teardown
    Close Connection