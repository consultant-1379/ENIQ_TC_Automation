*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if verify_tables is running or not
    [Tags]             Restore
    ${Content}=        Get File                   Restore-DBCC.log
    Set Global Variable     ${Content}
    Should Contain     ${Content}                 User has run verify_tables
    
Checking if all tables are checked or not
    [Tags]             Restore
    Should Contain     ${Content}                 All tables will be checked
    
Checking for zero damaged index errors
    [Tags]             Restore
    Should Contain     ${Content}                 No damaged index errors found
    
Checking if FullRun is successful or not
    [Tags]             Restore
    Should Contain     ${Content}                 This run is completed successfully
