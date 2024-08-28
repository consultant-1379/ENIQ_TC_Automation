*** Settings ***
Force Tags      suite
Library         SSHLibrary
Library         String
Resource        ../../Resources/Keywords/Cli.robot
Resource        ../../Resources/Keywords/Variables.robot
Resource        ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot


*** Test Cases ***
Checking the creation of InDirectories
    [Tags]    fls
    Connect to server as a dcuser
    Checking whether inDirectories for each node is created in the path

*** Keywords ***
Checking whether inDirectories for each node is created in the path
    symboliclinkcreator_FLS_keywords.Execute the Command    cd ${inDir}
    ${Indir_files}=    symboliclinkcreator_FLS_keywords.Execute the Command    ${ls}
    verify indirs are created    ${Indir_files}
    [Teardown]    Test teardown

Test teardown
    Close Connection
