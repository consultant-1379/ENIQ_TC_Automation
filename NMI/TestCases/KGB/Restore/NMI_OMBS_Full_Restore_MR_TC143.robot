*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking user input for server information
    [Tags]                    Restore   MR
    ${FULL_DATA_Restore}=     Get File                        OMBS-Full-Data-Restore-MR.log
    Set Global Variable       ${FULL_DATA_Restore}
    Should Contain            ${FULL_DATA_Restore}            Getting Server Information from user
    
Checking user confirmation for server information
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            ENIQ_Statistics_Multi_Blade
    
Checking client server information for coordinator
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Displaying ENIQ client server information for stats_coordinator
    
Checking restore ombs_cfg directory stage is entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting to restore ombs_cfg directory on OMBS
    
Checking restore ombs_cfg directory stage is successfully completed
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully restored ombs_cfg directory on OMBS
    
Checking restore conf directory stage is entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting to restore conf directory on OMBS
    
Checking restore conf directory stage is successfully completed
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully restored conf directory on OMBS
    
Checking Prebackup run is started for coordinator
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting to run Prebackup on OMBS
    
Checking Prebackup run is successfully executed for coordinator
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully executed Prebackup on OMBS
    
Checking client server information for engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Displaying ENIQ client server information for stats_engine
    
Checking client server information for reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Displaying ENIQ client server information for dwh_reader_1

Checking client server information for reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Displaying ENIQ client server information for dwh_reader_2
    
Checking engine restore started in background
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  stats_engine
    
Checking reader1 restore started in background
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  dwh_reader_1
    
Checking reader2 restore started in background
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  dwh_reader_2
    
Checking coordinator restore started in background
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  stats_coordinator
    
Checking o_disable_policies stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_disable_policies
    
Checking o_disable_policies stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_disable_policies stage
    
Checking o_ssh_conf stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_ssh_conf
    
Checking o_ssh_conf stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_ssh_conf stage
    
Checking o_restore_bmr stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_bmr
    
Checking o_restore_bmr stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_bmr stage
    
Checking e_extract_bmr stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_extract_bmr
    
Checking e_extract_bmr stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_extract_bmr stage
    
Checking e_restore_stage1 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage1
    
Checking e_restore_stage1 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage1 stage
    
Checking o_restore_root stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_root
    
Checking o_restore_root stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_root stage
    
Checking e_restore_stage2 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage2
    
Checking e_restore_stage2 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage2 stage
    
Checking e_reboot_client stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client
    
Checking e_reboot_client stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client stage
    
Checking o_restore_bmr_1 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_bmr_1
    
Checking o_restore_bmr_1 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_bmr_1 stage
    
Checking e_extract_bmr_1 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_extract_bmr_1
    
Checking e_extract_bmr_1 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_extract_bmr_1 stage
    
Checking e_restore_stage3 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage3
    
Checking e_restore_stage3 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage3 stage
    
Checking e_reboot_client_1 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage4 stage
    
Checking o_restore_raw stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_raw
    
Checking o_restore_raw stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_raw stage
    
Checking e_restore_stage5 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_2 stage
    
Checking e_restore_stage6 stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage6 stage
    
Checking e_restart_services stage entered
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restart_services
    
Checking e_restart_services stage completed successfully
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restart_services stage
    
Checking restore started on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  stats_engine
    
Checking e_reboot_client_1 stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage4 stage
    
Checking e_restore_stage5 stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_2 stage
    
Checking e_restore_stage6 stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage6

Checking e_restore_stage6 stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage6 stage

Checking e_restart_services stage entered on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restart_services

Checking e_restart_services stage completed successfully on engine
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restart_services stage

Checking restore started on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  dwh_reader_1 
                
Checking e_reboot_client_1 stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage4 stage

Checking e_restore_stage5 stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage5 stage

Checking o_restore_eniq stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_eniq stage

Checking e_reboot_client_2 stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_2 stage

Checking e_restore_stage6 stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage6 stage

Checking e_restart_services stage entered on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restart_services
    
Checking e_restart_services stage completed successfully on reader1
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restart_services stage

Checking restore started on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  dwh_reader_2

Checking e_reboot_client_1 stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_1 stage

Checking e_restore_stage4 stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage4 stage

Checking e_restore_stage5 stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage5 stage

Checking o_restore_eniq stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_eniq stage

Checking e_reboot_client_2 stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_2 stage

Checking e_restore_stage6 stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage6 stage

Checking e_restart_services stage entered on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restart_services
    
Checking e_restart_services stage completed successfully on reader2
    [Tags]                    Restore   MR
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restart_services stage
