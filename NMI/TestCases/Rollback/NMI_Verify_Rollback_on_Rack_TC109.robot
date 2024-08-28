*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Rollback stage - get_active_snapshot is entered successfully
    [Tags]             Rollback  Rack
    ${RB_Rack_Log}=    Get File                   Rollback-Rack.log
	Set Global Variable      ${RB_Rack_Log}
    Should Contain     ${RB_Rack_Log}             Entering Rollback stage - get_active_snapshot
	
Checking if active snapshot label is fetched successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Completed Stage - Get active snapshot label
	
Checking if rollback stage - disable_oss_mounts is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering rollback stage - disable_oss_mounts
	
Checking if rollback Stage - disable_oss_mounts is completed successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Completed Stage - disabled OSS Mounts on all required Servers
	
Checking if Rollback stage - rollback_fs_snapshot is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - rollback_fs_snapshot
	
Checking if rollback of FS snapshots is started
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Starting to rollback FS snapshots
	
Checking if Stage - rolled back FS snapshot is completed successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Completed Stage - rolled back FS snapshot
	
Checking if Rollback stage - rollback_nas_snapshot is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - rollback_nas_snapshot
	
Checking if rollback Stage - rollback_nas_snapshot for rack is skipped
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 INFO: Skipping Rollback Stage - rollback_nas_snapshot for Rack
	
Checking if Rollback stage - rollback_san_snapshot is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - rollback_san_snapshot
	
Checking if Rollback Stage - rollback_san_snapshot for Rack is skipped
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 INFO: Skipping Rollback Stage - rollback_san_snapshot for Rack
	
Checking if Rollback stage - restore_repository_database is successfully entered
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - restore_repository_database
	
Checking if Rollback Stage - restore_repository_database is skipped
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 INFO: Skipping Rollback Stage - restore_repository_database for Rack
	
Checking if Rollback stage - restore_dwhdb_database is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - restore_dwhdb_database
	
Checking if Rollback Stage - restore_dwhdb_database is skipped
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 INFO: Skipping Rollback Stage - restore_dwhdb_database for Rack
	
Checking if Rollback stage - enable_rolling_snapshot is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - enable_rolling_snapshot
	
Checking if svc:/eniq/roll-snap:default service is started successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Successfully started svc:/eniq/roll-snap:default service
	
Checking if rolling snapshot service is enabled successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Completed Stage - successfully enabled rolling snapshot service
	
Checking if Rollback stage - post_rollback is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering Rollback stage - post_rollback
	
Checking if post rollback procedure is completed successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Completed Stage - successfully completed post rollback procedure
	
Checking if rollback stage - cleanup is entered successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Entering rollback stage - cleanup
	
Checking if the temporary files are cleaned up
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Cleaning up the temporary files
	
Checking if the temporary directory are cleaned up
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Cleaning up the temporary directory
	
Checking if cleanup is completed successfully
    [Tags]             Rollback  Rack
    Should Contain     ${RB_Rack_Log}                 Successfully completed the cleanup
