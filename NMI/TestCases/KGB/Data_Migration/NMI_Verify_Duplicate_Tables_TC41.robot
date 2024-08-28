*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if search for duplicates is started
    [Tags]                Migration
    ${Content}=           Get File                  Topology_Data.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                Starting to search tables with duplicates

Checking if search for duplicates is completed
    [Tags]             Migration
    ${Content}=        Get File                  Topology_Data.log
    Should Contain     ${Content}                Completed search for tables with duplicate data

Checking if duplicate data is found
    [Tags]             Migration
    ${Content}=        Get File                  Topology_Data.log
    Should Contain     ${Content}                No duplicate data found in the topology tables
