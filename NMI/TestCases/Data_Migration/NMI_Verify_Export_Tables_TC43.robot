*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if exporting tablres is finished    
    [Tags]                Data Migration
    ${Content}=           Get File                   Export.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Finished exporting tables from database
