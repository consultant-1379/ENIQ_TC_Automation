*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if verify_tables procedure is successfully started
    [Tags]                 Rack  Replacement
    ${Replacement}=        Get File                       Rack-Replacement-External.log
    Set Global Variable    ${Replacement} 	
    Should Contain         ${Replacement}                 User has run verify_tables

Checking Environment for this run is set successfully
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Environment for this run is set successfully
	
Checking if verify_tables procedure is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 This run is completed successfully
	
Checking if Pre-Replacement procedure for Rack Hardware replacement is successfully started
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Entering Pre-Replacement procedure for Rack Hardware replacement
	
Checking if check_scheduler_service stage is successfully started
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Entering prereplacement stage - check_scheduler_service
	
Checking if check_scheduler_service stage is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Successfully completed stage - check_scheduler_service
	
Checking if check_engine_service stage is successfully started
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Entering prereplacement stage - check_engine_service
	
Checking if check_engine_service stage is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Successfully completed stage - check_engine_service
	
Checking if commit_and_checkpoint stage is successfully started
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - commit_and_checkpoint
	
Checking if commit_and_checkpoint stage is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Successfully completed stage - commit_and_checkpoint
	
Checking if cleanup_prereplacement stage is successfully started
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - cleanup_prereplacement
	
Checking if cleanup_prereplacement stage is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Successfully completed stage - cleanup_prereplacement
	
Checking if Pre-Replacement procedure for Rack Hardware replacement is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Replacement}                 Successfully completed Pre-Replacement procedure for Rack Hardware replacement

Checking if Backup procedure for Rack Hardware replacement is successful
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 total size is

Checking if rack replacement procedure is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering Replacement procedure for Rack Hardware replacement.

Checking if restore_logs stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering replacement stage - restore_logs

Checking if restore_logs stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed - restore_logs
	
Checking if create_fls_fs stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering replacement stage - create_fls_fs
	
Checking if create_fls_fs stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed - create_fls_fs
	
Checking if restore_iq_file stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering replacement stage - restore_iq_file
	
Checking if restore_iq_file stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed - restore_iq_file
	
Checking if post_configuration stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering replacement stage - post_configuration
	
Checking if post_configuration stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed - post_configuration
	
Checking if create_snapshots stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering replacement stage - create_snapshots
	
Checking if create_snapshots stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully created Snapshots.
	
Checking if db_expansion stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering replacement stage - db_expansion
	
Checking if db_expansion stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed - db_expansion
	
Checking if cleanup_replacement stage is successfully started
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - cleanup_replacement
	
Checking if cleanup_replacement stage is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed - cleanup_replacement
	
Checking if rack replacement procedure is successfully completed
    [Tags]             Rack  Replacement
    Should Contain     ${Replacement}                 Successfully completed Replacement procedure for Rack Hardware replacement
	
Checking if restore procedure is successful
    [Tags]             Rack  Replacement  
    Should Contain     ${Replacement}                 Successfully completed Selective Restore
