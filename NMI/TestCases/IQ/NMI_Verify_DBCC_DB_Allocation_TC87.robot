*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if db_allocation is running or not
    [Tags]             DBCC Memory
    ${Content}=        Get File                   DB_Allocation.log
    Set Global Variable     ${Content}
    Should Contain     ${Content}                 User has run db_allocation

Checking if current Engine profile is Normal
    [Tags]             DBCC Memory
    Should Contain     ${Content}                 is Normal

Checking if Engine profile is changed from Normal to NoLoads
    [Tags]             DBCC Memory
    Should Contain     ${Content}                 changed from Normal to NoLoads successfully

Checking if current Engine profile is NoLoads
    [Tags]             DBCC Memory
    Should Contain     ${Content}                 is NoLoads

Checking if Engine profile is reverted to Normal
    [Tags]             DBCC Memory
    Should Contain     ${Content}                 Reverting engine profile
