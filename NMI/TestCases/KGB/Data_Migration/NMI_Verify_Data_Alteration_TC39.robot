*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking for data alteration
    [Tags]             Disabling
    ${Content}=        Get File                  Data-Alteration.log
    Set Global Variable   ${Content}
    Should Contain     ${Content}                Performing data alteration for
