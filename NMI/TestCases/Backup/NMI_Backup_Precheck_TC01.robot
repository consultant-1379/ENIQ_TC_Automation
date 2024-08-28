*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if pre_backup.bsh is successfully started
    [Tags]             OMBS  B&R
    ${ombs_full_backup_MB}=    Get File                       Backup-Precheck.log
    Set Global Variable        ${ombs_full_backup_MB}    
    Should Contain     ${ombs_full_backup_MB}                 Restarting the EMC Host Agent

Checking if pre_backup.bsh is successfully ongoing
    [Tags]             OMBS  B&R    
    Should Contain     ${ombs_full_backup_MB}                 Enabling Arraycommpath for storage group

Checking if pre_backup.bsh is successfully completed
    [Tags]             OMBS  B&R    
    Should Contain     ${ombs_full_backup_MB}                 **Pre-backup completed successfully**
