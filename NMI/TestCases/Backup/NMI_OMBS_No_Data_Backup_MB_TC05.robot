*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if get_ombs_info.bsh script execution successfully started
    [Tags]                 OMBS     B&R
    ${OMBS}=               Get File            OMBS-No-Data-Backup-MB.log
    Set Global Variable    ${OMBS}   
    Should Contain         ${OMBS}             Started executing /eniq/bkup_sw/bin/get_ombs_info.bsh

Checking if get_backup_option.bsh script execution successfully started
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Starting to execute /eniq/bkup_sw/bin/get_backup_option.bsh
    
Checking if create_ombs_info.bsh script is successfully running
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Running /eniq/bkup_sw/bin/create_ombs_info.bsh
    
Checking if /eniq/bkup_sw/ombs_cfg directory is creating
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Creating /eniq/bkup_sw/ombs_cfg directory 
    
Generating lun list
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Generating lun list
    
Checking if files started to copy
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Started copying files in /eniq/bkup_sw/ombs_cfg 
    
Checking if copied successfully
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Successfully copied all the required files in /eniq/bkup_sw/ombs_cfg 
    
Sharing /eniq/bkup_sw/ombs_cfg file system with OMBS server
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Sharing /eniq/bkup_sw/ombs_cfg file system with OMBS server
    
Starting to update crontab
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Updating crontab with /eniq/bkup_sw/bin/raw_backup_supervisor.bsh entry
    
Checking if crontab successfully updated
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 /eniq/bkup_sw/bin/raw_backup_supervisor.bsh already added in crontab
    
Checking if get_ombs_info.bsh script execution successfully completed
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Successfully executed /eniq/bkup_sw/bin/get_ombs_info.bsh
    
Checking if pre_backup.bsh is successfully started
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Restarting the EMC Host Agent
    
Checking if pre_backup.bsh is successfully ongoing
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Enabling Arraycommpath for storage group
    
Checking if pre_backup.bsh is successfully completed
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 **Pre-backup completed successfully**
 
Creating an ENIQ Backup Policy process for each ENIQ-S server started.
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Checking for NBU processes
    
ENIQ Backup Policy process starting message
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 OMBS Server: CREATING BACKUP POLICIES                     
    
Creating password-less connection towards the client in ENIQ Backup Policy process
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Creating password-less connection towards the client
    
Creating NBU policy in ENIQ Backup Policy process.
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Creating NBU policy for
    
Adding cron supervisor in ENIQ Backup Policy process.
    [Tags]            OMBS     B&R    
    Should Contain    ${OMBS}                 Adding cron supervisor
    
Activating policies in ENIQ Backup Policy process.
    [Tags]            OMBS     B&R  
    Should Contain    ${OMBS}                 Activating policies
