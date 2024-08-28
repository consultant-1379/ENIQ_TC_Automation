*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/repdb_connection.robot
    

*** Test Cases ***
Verify the db connections using CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${Dwhrep_output}=    Connect to dwhrep in CLi
    Verify the msg    ${Dwhrep_output}    (dwhrep) 
    Execute the Command    Exit
    ${dc_output}=    Connect to dc username in CLI
    Verify the msg    ${dc_output}    (dc)
    Execute the Command    Exit
    ${etlrep_output}=    Connect to etlrep connection in CLI
    Verify the msg    ${etlrep_output}    (etlrep)
    Execute the Command    Exit

*** Keywords ***
Test Teardown
    Close All Connections
