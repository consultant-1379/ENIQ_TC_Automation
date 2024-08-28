*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if verify_tables is running or not
    [Tags]             DeltaRun
    ${Content}=        Get File                   DBCC_Delta_Run.log
    Set Global Variable     ${Content}
    Should Contain     ${Content}                 User has run verify_tables

Checking if all tables are checked or not
    [Tags]             DeltaRun
    Should Contain     ${Content}                 This is a delta run

Checking for zero damaged index errors
    [Tags]             DeltaRun
    Should Contain     ${Content}                 No damaged index errors found

Checking if FullRun is successful or not
    [Tags]             DeltaRun
    Should Contain     ${Content}                 This run is completed successfully

