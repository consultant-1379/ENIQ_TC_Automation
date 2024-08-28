*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Resource    ../../Resources/Keywords/repdb_connection.robot

*** Test Cases *** 
Verify all the nodes which is available in node assignment table have data load
    [Tags]    FLS
    Connect to server as a dcuser
    Verifying the proper loading of data in node assignment table 

*** Keywords ***
Verifying the proper loading of data in node assignment table 
    connect to repdb
    ${output}=    symboliclinkcreator_FLS_keywords.run the sql query    ${select_NAT_table_query}
    verify the file is not empty    ${output}
    [Teardown]    Test teardown

Test teardown
    Close Connection



