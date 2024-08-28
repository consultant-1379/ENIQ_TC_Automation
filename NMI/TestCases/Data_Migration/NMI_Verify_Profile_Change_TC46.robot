*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if profile is changed     
    [Tags]                Data Migration
    ${Content}=           Get File              Profile_Change.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}            Finished Loading active partitions. Changing engine back to Normal profile
