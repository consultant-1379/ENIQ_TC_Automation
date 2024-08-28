*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Checking if pre_migration started successfully.
    [Tags]             Blade  Migration
    ${Pre_Blade_Migration}=    Get File                       Pre-Migration.log
    Set Global Variable        ${Pre_Blade_Migration} 
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Backup procedure for Linux OS Migration.
    Should Be Equal As Strings    ${count}                   4	                 

Determining which stage file to use
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Building stage list from /var/tmp/upgrade/premig/core_install/etc/eniq_linux_premigration_stagelist
	
Checking if Linux premigration stage - get_migration_data is successfully started
    [Tags]             Blade  Migration                     
	${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - get_migration_data
    Should Be Equal As Strings    ${count}                   4	        
	
Checking if IMPORTANT information for Migration backup server IP address is successfully displayed
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Migration backup server IP address
	
Checking if IMPORTANT information for Directory path of Migration backup is successfully displayed
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Directory path of Migration backup
	
Checking Zpool LUN ID for Co-Ordinator server
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 LUN IDs Of Co-Ordinator 
	
Checking Zpool LUN ID for ENGINE server
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 LUN IDs Of ENGINE  
	
Checking Zpool LUN ID for Reader1 server
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 LUN IDs Of Reader1 
	
Checking Zpool LUN ID for Reader2 server
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 LUN IDs Of Reader2 
	
Checking if Migration SW scripts is successfully Successfully backed up.
    [Tags]             Blade  Migration                     
	${count}=          Get Count              ${Pre_Blade_Migration}               Successfully backed up Migration SW scripts to /eniq/backup/migration_sw.
    Should Be Equal As Strings    ${count}                   4
	
	
Checking if premigration stage - get_migration_data is successfully completed.
    [Tags]             Blade  Migration                    
	${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed - get_migration_data
    Should Be Equal As Strings    ${count}                   4	
	
Checking if Linux premigration stage - create_snapshots successfully started
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Starting to run /usr/bin/bash /eniq/bkup_sw/bin/prep_eniq_snapshots.bsh 
	
Checking if Prepare eniq snapshots successfully started
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Prepare eniq snapshots started 
	
Stopping Rolling Snapshot Service 
    [Tags]             Blade  Migration                     
	${count}=          Get Count              ${Pre_Blade_Migration}                Stopping services on 
    Should Be Equal As Strings    ${count}                   4  

Checking if ENIQ services stopped correctly.
    [Tags]             Blade  Migration    
	${count}=          Get Count              ${Pre_Blade_Migration}                ENIQ services stopped correctly on
    Should Be Equal As Strings    ${count}                   4   
	
Starting to create NFS snapshots
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Starting to create NFS snapshots

Starting to create ZFS snapshots
	[Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Creating snapshots with label
	
Starting to delete ZFS snapshots
	[Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Deleting ZFS snapshots with label

Checking if Rolling Snapshot successfully created.
    [Tags]             Blade  Migration                     
	${count}=          Get Count              ${Pre_Blade_Migration}                Rolling Snapshot successfully created on ENIQ Server
    Should Be Equal As Strings    ${count}                   4
	
checking if /eniq/bkup_sw/bin/prepare_eniq_bkup.bsh Successfully finished on server
    [Tags]             Blade  Migration                     
	${count}=          Get Count              ${Pre_Blade_Migration}                Successfully finished /eniq/bkup_sw/bin/prepare_eniq_bkup.bsh on server
    Should Be Equal As Strings    ${count}                   4

Checking if Prepare eniq snapshots successfully finished
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Prepare ENIQ snapshots finished successfully
	
Checking if Linux premigration stage - create_snapshots successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Successfully created Snapshots - create_snapshots
	
Checking if Linux premigration stage - create_nas_fs is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - create_nas_fs
    Should Be Equal As Strings    ${count}                   4
	
Checking if NAS filesystem is successfully shared
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Successfully shared NAS filesystem
	
Checking if Linux premigration stage - create_nas_fs is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Pre_Blade_Migration}                 Successfully completed - create_nas_fs
	
Checking if Linux premigration stage - remote_premigration is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - remote_premigration
    Should Be Equal As Strings    ${count}                   4
	
Checking if premigration is successfully started on remote server.
    [Tags]             Blade  Migration    
	${count}=          Get Count              ${Pre_Blade_Migration}                Starting Premigration on
    Should Be Equal As Strings    ${count}                   3
	
Checking if Linux premigration stage - backup_iqheader is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - backup_iqheader
    Should Be Equal As Strings    ${count}                   4
	
Checking if Linux premigration stage - backup_iqheader is successfully completed
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed - backup_iqheader
    Should Be Equal As Strings    ${count}                   3
	
Checking if Linux premigration stage - backup_nas_data is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - backup_nas_data
    Should Be Equal As Strings    ${count}                   4
	
Checking if Linux premigration stage - backup_zfs_data is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - backup_zfs_data
    Should Be Equal As Strings    ${count}                   4

Checking if Linux premigration stage - backup_zfs_data is successfully completed
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed - backup_zfs_data
    Should Be Equal As Strings    ${count}                   4
	
Checking if Linux premigration stage - backup_root_data is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - backup_root_data
    Should Be Equal As Strings    ${count}                   4

Checking if Linux premigration stage - backup_root_data is successfully completed
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed - backup_root_data
    Should Be Equal As Strings    ${count}                   4
	
Checking if Linux premigration stage - disconnect_storage is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - disconnect_storage
    Should Be Equal As Strings    ${count}                   4

Checking if Linux premigration stage - disconnect_storage is successfully completed
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed - disconnect_storage
    Should Be Equal As Strings    ${count}                   4
	
Checking if Linux premigration stage - cleanup_premigration is successfully started
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Entering Linux premigration stage - cleanup_premigration
    Should Be Equal As Strings    ${count}                   4

Checking if Linux premigration stage - cleanup_premigration is successfully completed
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed - cleanup_premigration
    Should Be Equal As Strings    ${count}                   4
	
Checking if pre_migration successfully completed
    [Tags]             Blade  Migration    
    ${count}=          Get Count              ${Pre_Blade_Migration}                Successfully completed Backup procedure for Linux OS Migration.
    Should Be Equal As Strings    ${count}                   4
