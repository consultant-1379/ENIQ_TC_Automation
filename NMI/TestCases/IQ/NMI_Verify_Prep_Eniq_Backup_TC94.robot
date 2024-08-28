*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if Backup is timed out
    [Tags]             OMBS DBCC
    ${Content}=        Get File                   Prep-ENIQ-backup.log
    Set Global Variable    ${Content}
    Should Contain     ${Content}                 Backup timed out as DBCC is still checking for corruption due to high number of tables

Checking if Backup is triggered during next scheduled backup
    [Tags]             OMBS DBCC
    Should Contain     ${Content}                 Backup will be triggered during next scheduled backup
