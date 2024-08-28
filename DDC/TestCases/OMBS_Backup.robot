*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for backup_precheck file in OMBS Source
    [Documentation]       Checking for backup_precheck.log file in /eniq/local_logs/backup_logs directory
    [Tags]                OMBS_Backup
    Check File Exists     /eniq/local_logs/backup_logs/backup_precheck.log

Checking for backup_precheck file size in OMBS Source
    Depends on test       Checking for backup_precheck file in OMBS Source
    [Documentation]       Checking for non empty backup_precheck.log file in /eniq/local_logs/backup_logs directory
    [Tags]                OMBS_Backup
    Check File Size       /eniq/local_logs/backup_logs/backup_precheck.log

Checking for prep_eniq_backup file in OMBS destination
    Depends on test       Checking for backup_precheck file in OMBS Source
    [Documentation]       Checking for prep_eniq_backup.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/OMBS_Backup directory
    [Tags]                OMBS_Backup
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/OMBS_Backup/prep_eniq_backup.log

Checking for prep_eniq_backup file size in OMBS destination
    Depends on test       Checking for backup_precheck file in OMBS destination
    [Documentation]       Checking for non empty prep_eniq_backup.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/OMBS_Backup directory
    [Tags]                OMBS_Backup
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/OMBS_Backup/prep_eniq_backup.log
