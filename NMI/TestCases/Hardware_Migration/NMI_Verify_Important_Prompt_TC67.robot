*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Validate details displayed at the beginning in IMPORTANT prompt
    [Tags]             Migration
    ${Content}=        Get File                   Pre-Migration.log
    Should Contain     ${Content}                 PLEASE SAVE THE FOLLOWING INFORMATION
