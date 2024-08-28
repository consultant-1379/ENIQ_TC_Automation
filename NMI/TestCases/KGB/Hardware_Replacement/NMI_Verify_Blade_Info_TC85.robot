*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if IP address of Replacement Config backup server is successfully displayed
    [Tags]                    Blade replacement
    ${Pre-Rep}=               Get File                   Replacement-SB.log
    Set Global Variable       ${Pre-Rep}
    Should Contain            ${Pre-Rep}                 IP address of Replacement Config backup server

Checking if Directory of Replacement Config on backup server is successfully displayed
    [Tags]             Blade replacement   
    Should Contain     ${Pre-Rep}                 Directory of Replacement Config on backup server
