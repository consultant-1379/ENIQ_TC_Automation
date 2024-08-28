*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/repdb_connection.robot


*** Test Cases ***
Verify the Check if there are any partition in an inactive state in the CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    Connect to dwhrep in CLi
    ${DWH_partition}=    Execute the Command    Select TABLENAME From DWHPartition Where STATUS != 'ACTIVE'
    Verify the zero rows in CLI    ${DWH_partition}    (0 rows)
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections