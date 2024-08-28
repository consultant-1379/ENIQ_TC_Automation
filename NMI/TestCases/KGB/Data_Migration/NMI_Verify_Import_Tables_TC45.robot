*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if import is completed     
    [Tags]                Data Migration
    ${Content}=           Get File                   Import.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Finished importing historic tables into database
