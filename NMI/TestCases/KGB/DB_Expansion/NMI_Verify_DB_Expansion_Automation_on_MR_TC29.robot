*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Entering expansion stage - get_expansion_inputs is entered successfully
    [Tags]                DB-Expansion  MR
    ${DB_MB_Log}=         Get File                  DB_expansion_automation.log
    Set Global Variable   ${DB_MR_Log}
    Should Contain        ${DB_MR_Log}              Entering expansion stage - get_expansion_inputs

Checking if get_expansion_inputs file is created succcesfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - get_expansion_inputs

Checking if Entering expansion stage - setup_ssh_connectivity is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering expansion stage - setup_ssh_connectivity

Checking if setup_ssh_connectivity file is created successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - setup_ssh_connectivity

Checking if expansion stage - storage_expansion is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering expansion stage - storage_expansion
	
Checking if storage_expansion is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - storage_expansion

Checking if expansion stage - Reboot_ENIQ is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering expansion stage - Reboot_ENIQ

Checking if Reboot_ENIQ is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - Reboot_ENIQ

Checking if expansion stage - database_expansion is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering expansion stage - database_expansion

Checking if Executing DB Expansion is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Executing DB Expansion

Checking if DB Expansion stage - get_expansion_details is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering DB Expansion stage - get_expansion_details

Checking if get_expansion_details is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - get_expansion_details

Checking if ENIQ DB Expansion stage - prerequisite_validation is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering ENIQ DB Expansion stage - prerequisite_validation

Checking if prerequisite_validation is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - prerequisite_validation

Checking if ENIQ DB Expansion stage - stop_rollsnap_services is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Entering ENIQ DB Expansion stage - stop_rollsnap_services

Checking if stop_rollsnap_services is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - stop_rollsnap_services

Checking if ENIQ DB Expansion stage - disabling_OMBS_policies is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - disabling_OMBS_policies

Checking if disabling_OMBS_policies is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - disabling_OMBS_policies

Checking if ENIQ DB Expansion stage - snapshot_creation is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - snapshot_creation

Checking if snapshot_creation is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - snapshot_creation

Checking if ENIQ DB Expansion stage - niqini_backup is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - niqini_backup

Checking if niqini_backup is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - niqini_backup

Checking if ENIQ DB Expansion stage - memory_expansion is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - memory_expansion

Checking if memory_expansion is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              INFO: Skipping execution, as memory re-allocation not required for Multi-Rack Deployment

Checking if ENIQ DB Expansion stage - add_mainDb is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - add_mainDb

Checking if add_mainDb is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - add_mainDb

Checking if ENIQ DB TempDB Addition Stage - add_tempdb is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB TempDB Addition Stage - add_tempdb

Checking if add_tempdb is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - add_tempdb

Checking if ENIQ DB Expansion stage - add_sysmainDb is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - add_sysmainDb

Checking if add_sysmainDb is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - add_sysmainDb

Checking if ENIQ DB Expansion stage - post_expansion_configuration is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB Expansion stage - post_expansion_configuration

Checking if post_expansion_configuration is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - post_expansion_configuration

Checking if ENIQ DB  stage - cleanup is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB  stage - cleanup

Checking if cleanup is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed the cleanup

Checking if ENIQ DB  stage - cleanup is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering ENIQ DB  stage - cleanup

Checking if cleanup is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed the cleanup

Checking if database_expansion is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - database_expansion

Checking if expansion stage - post_expansion is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering expansion stage - post_expansion

Checking if post_expansion is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - post_expansion

Checking if expansion stage - cleanup is entered successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}               Entering expansion stage - cleanup

Checking if cleanup is completed successfully
    [Tags]                DB-Expansion  MR
    Should Contain        ${DB_MR_Log}              Successfully completed - cleanup

Checking if any ERRORS in logfile 
    [Tags]                DB-Expansion  MR
    Should Not Contain      ${DB_MR_Log}		    ERROR				ignore_case=True
