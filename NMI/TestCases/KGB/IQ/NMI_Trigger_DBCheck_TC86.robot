*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if tables are being verified
    [Tags]                IQ
    ${Content}=           Get File                  DB-Check.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                User has run verify_tables

Checking if run is completed successfully
    [Tags]             IQ
    ${Content}=        Get File                  DB-Check.log
    Should Contain     ${Content}                This run is completed successfully
