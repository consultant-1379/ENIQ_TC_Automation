*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking user input for server information
    [Tags]                    Restore    MB
    ${NO_DATA_Restore}=        Get File                        OMBS-No-Data-Restore-MB.log
    Set Global Variable        ${NO_DATA_Restore}
    Should Contain            ${NO_DATA_Restore}                Getting Server Information from user
    
Checking user confirmation for server information
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Selected Server type is: ENIQ_Statistics_Multi_Blade
    
Checking client server information for coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Displaying ENIQ client server information for stats_coordinator
    
Checking restore ombs_cfg directory stage is entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting to restore ombs_cfg directory on OMBS
    
Checking restore ombs_cfg directory stage is successfully completed
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully restored ombs_cfg directory on OMBS
    
Checking restore conf directory stage is skipped for coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping this stage as this is NoData backup
    
Checking Prebackup run is started for coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting to run Prebackup on OMBS
    
Checking Prebackup run is successfully executed for coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully executed Prebackup on OMBS
    
Checking client server information for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Displaying ENIQ client server information for stats_engine
    
Checking restore ombs_conf directory stage is skipped for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping ombs_cfg restore as this is non coordinator blade
    
Checking restore conf directory stage is skipped for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping this stage as this is non coordinator blade
    
Checking Prebackup run is started for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting to run Prebackup on OMBS
    
Checking Prebackup run is successfully executed for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully executed Prebackup on OMBS
    
Checking client server information for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Displaying ENIQ client server information for dwh_reader_1
    
Checking restore ombs_conf directory stage is skipped for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping ombs_cfg restore as this is non coordinator blade
    
Checking restore conf directory stage is skipped for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping this stage as this is non coordinator blade
    
Checking Prebackup run is started for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting to run Prebackup on OMBS
    
Checking Prebackup run is successfully executed for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully executed Prebackup on OMBS
    
Checking client server information for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Displaying ENIQ client server information for dwh_reader_2
    
Checking restore ombs_conf directory stage is skipped for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping ombs_cfg restore as this is non coordinator blade
    
Checking restore conf directory stage is skipped for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Skipping this stage as this is non coordinator blade
    
Checking Prebackup run is started for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting to run Prebackup on OMBS
    
Checking Prebackup run is successfully executed for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully executed Prebackup on OMBS
    
Checking engine restore started in background
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  stats_engine
    
Checking reader1 restore started in background
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  dwh_reader_1
    
Checking reader2 restore started in background
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  dwh_reader_2
    
Checking restore started on coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  stats_coordinator
    
Checking o_disable_policies stage entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_disable_policies
    
Checking o_disable_policies stage completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_disable_policies stage
    
Checking o_ssh_conf stage entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_ssh_conf
    
Checking o_ssh_conf stage completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_ssh_conf stage
    
Checking o_restore_bmr stage entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_bmr  

Checking o_restore_bmr stage completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_bmr stage 
    
Checking e_extract_bmr stage entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_extract_bmr
    
Checking e_extract_bmr stage completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_extract_bmr stage

Checking e_restore_stage1 stage entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage1

Checking e_restore_stage1 stage completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage1 stage
    
Checking o_restore_root stage entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_root 
    
Checking o_restore_root stage completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_root stage
    
Checking e_restore_stage2 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage2
    
Checking e_restore_stage2 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage2 stage
    
Checking e_reboot_client entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client
    
Checking e_reboot_client completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client stage
    
Checking o_restore_bmr_1 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_bmr_1
    
Checking o_restore_bmr_1 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_bmr_1 stage
    
Checking e_extract_bmr_1 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_extract_bmr_1
    
Checking e_extract_bmr_1 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_extract_bmr_1 stage
    
Checking e_restore_stage3 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage3
    
Checking e_restore_stage3 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage3 stage
    
Checking e_reboot_client_1 entered for coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 completed successfully for coordinator
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage4 stage
    
Checking o_restore_raw entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_raw
    
Checking o_restore_raw completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_raw stage
    
Checking e_restore_stage5 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_2 stage
    
Checking e_restore_stage6 entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage6 stage

Checking e_restart_services entered
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restart_services
    
Checking e_restart_services completed successfully
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restart_services stage
    
Checking restore started on engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  stats_engine
    
Checking e_reboot_client_1 entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage4 stage
    
Checking e_restore_stage5 entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_2 stage
    
Checking e_restore_stage6 entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage6 stage
    
Checking e_restart_services entered for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restart_services
    
Checking e_restart_services completed successfully for engine
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restart_services stage
    
Checking restore started on reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  dwh_reader_1
    
Checking e_reboot_client_1 entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage4 stage
    
Checking e_restore_stage5 entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_2 stage

Checking e_restore_stage6 entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage6 stage
    
Checking e_restart_services entered for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restart_services
    
Checking e_restart_services completed successfully for reader1
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restart_services stage
    
Checking restore started on reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Starting restore on  dwh_reader_2
    
Checking e_reboot_client_1 entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage4 stage
    
Checking e_restore_stage5 entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_reboot_client_2 stage
    
Checking e_restore_stage6 entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restore_stage6 stage
    
Checking e_restart_services entered for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Entering restore stage - e_restart_services
    
Checking e_restart_services completed successfully for reader2
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Successfully completed e_restart_services stage
    
Checking restore completed on MB
    [Tags]                    Restore    MB
    Should Contain            ${NO_DATA_Restore}                Restore is successfully completed
