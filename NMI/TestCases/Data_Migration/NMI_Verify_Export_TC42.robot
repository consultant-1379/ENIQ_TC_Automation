*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if table extraction is started
    [Tags]                Migration
    ${Content}=           Get File              Extract.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}            Starting to extract tables from database

Checking if table extraction is completed
    [Tags]                Migration
    ${Content}=           Get File              Extract.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}            Completed extracting tables from database
