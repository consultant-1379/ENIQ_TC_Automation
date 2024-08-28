*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Checking if post recovery started successfully.
    [Tags]             Blade  Migration
    ${recovery_Migration}=    Get File                       Post-Recovery.log
    Set Global Variable        ${recovery_migration} 
    Should Contain     ${recovery_migration}                 triggering Update_Dates
	
Checking Update_Dates have been executed successfully.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Update_Dates have been executed
	
Execution of cleanup_logdir is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 triggering Cleanup_logdir

Executed of cleanup_logdir is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Cleanup_logdir have been executed
	
Execution of Cleanup_transfer_batches is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 triggering Cleanup_transfer_batches

Executed of Cleanup_transfer_batches is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Cleanup_transfer_batches have been executed
	
Execution of Trigger_Partitioning is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 triggering Trigger_Partitioning

Executed of Trigger_Partitioning is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Trigger_Partitioning has been executed
	
Execution of UpdateFirstLoadings is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 triggering UpdateFirstLoadings

Executed of UpdateFirstLoadings is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 UpdateFirstLoadings has been executed
	
Execution of AggregationRuleCopy is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 triggering AggregationRuleCopy

Executed of AggregationRuleCopy is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 AggregationRuleCopy has been executed
	
Checking post_rollback is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 post_rollback script has finished successfully.
