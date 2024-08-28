*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Resource    ../../Resources/Keywords/repdb_connection.robot

*** Test Cases *** 
Checking the NAT table and FLS restart
    [Tags]    FLS
    Connect to server as a dcuser
    Clearing the NAT table and fls restart

*** Keywords ***
Clearing the NAT table and fls restart
    connect to repdb
    ${output}=    symboliclinkcreator_FLS_keywords.run the sql query  ${delete_NAT_table_query}
    verifying NAT table should be empty    ${output}    ${rows_deleted}
    restart the fls    ${fls_restart}
    [Teardown]    Test teardown

Test teardown
    Close Connection

