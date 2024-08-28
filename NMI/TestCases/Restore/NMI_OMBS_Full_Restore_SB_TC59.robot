*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking user input for server information
    [Tags]                    Restore   SB
    ${FULL_DATA_Restore}=    Get File                        OMBS-Full-Data-Restore-SB.log
    Set Global Variable        ${FULL_DATA_Restore}
    Should Contain            ${FULL_DATA_Restore}            Getting Server Information from user
    
Checking user confirmation for server information
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            ENIQ_Statistics_Single_Blade
    
Checking restore started on Single Blade
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Starting restore on  eniq_stats
    
Checking o_disable_policies stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_disable_policies
    
Checking o_disable_policies stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_disable_policies stage
    
Checking o_ssh_conf stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_ssh_conf
    
Checking o_ssh_conf stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_ssh_conf stage
    
Checking o_restore_bmr stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_bmr
    
Checking o_restore_bmr stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_bmr stage
    
Checking e_extract_bmr stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_extract_bmr
    
Checking e_extract_bmr stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_extract_bmr stage
    
Checking e_restore_stage1 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage1
    
Checking e_restore_stage1 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage1 stage
    
Checking o_restore_root stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_root
    
Checking o_restore_root stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_root stage
    
Checking e_restore_stage2 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage2
    
Checking e_restore_stage2 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage2 stage
    
Checking e_reboot_client stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client
    
Checking e_reboot_client stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client stage
    
Checking o_restore_bmr_1 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_bmr_1
    
Checking o_restore_bmr_1 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_bmr_1 stage
    
Checking e_extract_bmr_1 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_extract_bmr_1
    
Checking e_extract_bmr_1 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_extract_bmr_1 stage
    
Checking e_restore_stage3 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage3
    
Checking e_restore_stage3 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage3 stage
    
Checking e_reboot_client_1 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_1
    
Checking e_reboot_client_1 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_1 stage
    
Checking e_restore_stage4 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage4
    
Checking e_restore_stage4 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage4 stage
    
Checking o_restore_raw stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_raw
    
Checking o_restore_raw stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_raw stage
    
Checking e_restore_stage5 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage5
    
Checking e_restore_stage5 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage5 stage
    
Checking o_restore_eniq stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - o_restore_eniq
    
Checking o_restore_eniq stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed o_restore_eniq stage
    
Checking e_reboot_client_2 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_reboot_client_2
    
Checking e_reboot_client_2 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_reboot_client_2 stage
    
Checking e_restore_stage6 stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restore_stage6
    
Checking e_restore_stage6 stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restore_stage6 stage
    
Checking e_restart_services stage entered
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Entering restore stage - e_restart_services
    
Checking e_restart_services stage completed successfully
    [Tags]                    Restore   SB
    Should Contain            ${FULL_DATA_Restore}            Successfully completed e_restart_services stage
