*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if FS snapshot creation has been started
    [Tags]               Snapshot
    ${Content}=           Get File                   Create-Snapshots.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Starting to create FS snapshots

Checking if FS snapshot is successfully created
    [Tags]               Snapshot
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 FS Snapshots with label
#
#Checking if SAN snapshot creation has been started
#    [Tags]               Snapshot
#    Set Global Variable   ${Content}
#    Should Contain        ${Content}                 Starting to create SAN snapshots
#
#Checking if SAN snapshot is successfully created
#    [Tags]               Snapshot
#    Set Global Variable   ${Content}
#    Should Contain        ${Content}                 Successfully created the SAN snapshots
