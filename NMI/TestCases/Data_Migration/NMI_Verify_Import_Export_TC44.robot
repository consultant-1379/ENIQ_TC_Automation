*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if export/import needs to be done via ‘failed option’ 
    [Tags]             Disabling
    ${Content}=        Get File                  Import-Export.log
    Set Global Variable   ${Content}
    Should Contain     ${Content}                A number of instances have failed to extract

Checking if exporting tables is completed
    [Tags]             Disabling
    ${Content}=        Get File                  Import-Export.log
    Set Global Variable   ${Content}
    Should Contain     ${Content}                Finished exporting tables from database
