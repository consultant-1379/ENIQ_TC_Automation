*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Rollback stage - get_active_snapshot is entered successfully
    [Tags]                        Rollback  MB
	${RB_MB_Log}=                 Get File                   Rollback-MB.log
	Set Global Variable      ${RB_MB_Log}
    Should Contain                ${RB_MB_Log}               Entering Rollback stage - get_active_snapshot
	
Checking if active snapshot label is fetched successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - Get active snapshot label
	
Checking if rollback stage - disable_oss_mounts is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering rollback stage - disable_oss_mounts
	
Checking if rollback Stage - disable_oss_mounts is completed successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - disabled OSS Mounts on all required Servers
	
Checking if Rollback stage - rollback_fs_snapshot is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering Rollback stage - rollback_fs_snapshot
	
	
Checking if rollback of FS snapshots is started on all blades
    [Tags]                        Rollback  MB
    ${count}=                     Get Count                  ${RB_MB_Log}              Starting to rollback FS snapshots
	Should Be Equal As Strings    ${count}                   4
	
Checking if Stage - rolled back FS snapshot is completed successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - rolled back FS snapshot
	
Checking if Rollback stage - rollback_nas_snapshot is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering Rollback stage - rollback_nas_snapshot
	
Checking if Rolling NAS snapshots with label is started
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Rolling NAS snapshots with label

Checking if NFS snapshots starts to rollback
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Starting to rollback NFS snapshots

Checking if Stage - rolled back NAS snapshot is completed successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - rolled back NAS snapshot
	
Checking if Rollback stage - rollback_san_snapshot is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering Rollback stage - rollback_san_snapshot
	
Checking if Rolling SAN snapshots with label is started
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Rolling SAN snapshots with label
	
Checking if Stage - rolled back SAN snapshot is successfully completed
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - rolled back SAN snapshot
	
Checking if Rollback stage - restore_repository_database is successfully entered
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering Rollback stage - restore_repository_database
	
Checking if Database is offline
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Database is now offline
	
Checking if database is Restored and Validated successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Database successfully Restored and Validated
	
Checking if the repository database is restored successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - successfully restored the repository database
	
Checking if Rollback stage - restore_dwhdb_database is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering Rollback stage - restore_dwhdb_database
	
Checking if dwhdb database is restored successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - successfully restored the dwhdb database
	
Checking if svc:/eniq/roll-snap:default service is started successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Successfully started svc:/eniq/roll-snap:default service
	
Checking if rolling snapshot service is enabled successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - successfully enabled rolling snapshot service
	
Checking if Rollback stage - post_rollback is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering Rollback stage - post_rollback
	
Checking if post rollback procedure is completed successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Completed Stage - successfully completed post rollback procedure
	
Checking if rollback stage - cleanup is entered successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Entering rollback stage - cleanup
	
Checking if the temporary files are cleaned up
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Cleaning up the temporary files
	
Checking if the temporary directory are cleaned up
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Cleaning up the temporary directory
	
Checking if cleanup is completed successfully
    [Tags]                        Rollback  MB
    Should Contain                ${RB_MB_Log}                 Successfully completed the cleanup
