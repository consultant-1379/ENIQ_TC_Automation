*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if Unpacking core sw procecdure successfully started
    [Tags]                Blade  Replacement
    ${Replacement}=       Get File                       Replacement-SB.log
	Set Global Variable   ${Replacement}  
    Should Contain        ${Replacement}                 Unpacking core sw started
	
Checking if Unpacking core sw procecdure successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully finished unpacking core SW
	
Checking if Prereplacement activity successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Starting prereplacement activity
	
Checking if prereplacement stage - get_replacement_data successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - get_replacement_data
	
Checking if IMPORTANT information successfully appears
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 PLEASE SAVE THE FOLLOWING INFORMATION
	
Checking if prereplacement stage - get_replacement_data successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - get_replacement_data
	
Checking if prereplacement stage - health_checks successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - health_checks
	
Checking if prereplacement stage - health_checks successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed health checks - health_checks
	
Checking if prereplacement stage - remote_prereplacement successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - remote_prereplacement
	
Checking if prereplacement stage - remote_prereplacement successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - remote_prereplacement
	
Checking if prereplacement stage - backup_iqheader successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - backup_iqheader
	
Checking if prereplacement stage - backup_iqheader successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - backup_iqheader
	
Checking if prereplacement stage - backup_root_data successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - backup_root_data
	
Checking if prereplacement stage - backup_root_data successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - backup_root_data
	
Checking if prereplacement stage - disconnect_vg successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - disconnect_vg
	
Checking if prereplacement stage - disconnect_vg successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - disconnect_vg
	
Checking if prereplacement stage - cleanup_prereplacement successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux prereplacement stage - cleanup_prereplacement
	
Checking if prereplacement stage - cleanup_prereplacement successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - cleanup_prereplacement
	
Checking if Prereplacement activity successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed Backup procedure for Linux Blade Replacement
	
Checking if Replacement Stage - install_emc_pkg is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Replacement Stage - install_emc_pkg
	
Checking if Replacement Stage - install_emc_pkg is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed Replacement Stage - install_emc_pkg

Checking if Replacement Stage - configure_stor_api is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Replacement Stage - configure_stor_api
	
Checking if Replacement Stage - configure_stor_api is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed Replacement Stage - configure_stor_api
	
Checking if Replacement Stage - import_vg is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Replacement Stage - import_vg
	
Checking if Replacement Stage - import_vg is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed Replacement Stage - import_vg
	
Checking if Linux Replacement stage start_replacement is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux Replacement stage start_replacement
	
Checking if replacement activity Started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Procedure for Linux Blade Replacement
	
Checking if Linux replacement stage - recreate_eniq_structure is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - recreate_eniq_structure
	
Checking if Linux replacement stage - recreate_eniq_structure is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - recreate_eniq_structure
	
Checking if Linux replacement stage - rep_stage_1 is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - rep_stage_1
	
Checking if core install stage - allow_root_access is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - allow_root_access
	
Checking if core install stage - allow_root_access is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed core install stage - allow_root_access
	
Checking if Linux replacement stage - rep_stage_1 is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - rep_stage_1
	
Checking if Linux replacement stage - rep_stage_2 is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - rep_stage_2
	
Checking if Linux Replacement stage start_replacement second time is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux Replacement stage start_replacement
	
Checking if Linux replacement stage - rep_stage_2 second time is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - rep_stage_2
	
Checking if core install stage - setup_ipmp is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - setup_ipmp
	
Checking if core install stage - setup_ipmp is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully setup bond
	
Checking if core install stage - update_netmasks_file is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - update_netmasks_file
	
Checking if core install stage - update_netmasks_file is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed core install stage - update_netmasks_file
	
Checking if core install stage - create_lun_map is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully created LUN Map ini file

Checking if core install stage - install_nas_sw is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - install_nas_sw
	
Checking if core install stage - install_nas_sw is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully installed NAS API
	
Checking if core install stage - create_nas_users is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - create_nas_users
	
Checking if core install stage - create_nas_users is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed stage - create_nas_users

Checking if Linux replacement stage - rep_stage_2 is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - rep_stage_2
	
Checking if Linux replacement stage - rep_stage_3 is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - rep_stage_3
	
Checking if core install stage - update_system_file is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - update_system_file
	
Checking if core install stage - update_system_file is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed core install stage - update_system_file
	
	
Checking if core install stage - update_defaultrouter_file is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - update_defaultrouter_file
	
Checking if core install stage - update_defaultrouter_file is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully updated /etc/sysconfig/network file
	
Checking if core install stage - install_nasd is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - install_nasd
	
Checking if core install stage - install_nasd is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully installed NASd
	
Checking if Linux replacement stage - rep_stage_3 is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - rep_stage_3
	
Checking if Linux replacement stage - rep_stage_4 is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - rep_stage_4
	
Checking if core install stage - create_groups is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - create_groups
	
Checking if core install stage - create_groups is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully created groups
	
Checking if core install stage - create_users is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - create_users
	
Checking if core install stage - create_users is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully created users
	
Checking if core install stage - change_mount_owners is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - change_mount_owners
	
Checking if core install stage - change_mount_owners is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully changed directory permissions
	
Checking if core install stage - install_host_syncd is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully installed hostsyncd
	
Checking if core install stage - generate_keys is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - generate_keys
	
Checking if core install stage - create_rbac_roles is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed configuration for ENIQ user roles
	
Checking if rep_stage_4 stage is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - rep_stage_4
	
Checking if Linux replacement stage - repair_sym_links is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - repair_sym_links
	
Checking if core install stage - create_db_sym_links is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - create_db_sym_links
	
Checking if core install stage - create_db_sym_links is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully created DB Sym Links
	
Checking if Linux replacement stage - repair_sym_links stage is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - repair_sym_links
	
Checking if Linux replacement stage - rep_stage_5 is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - rep_stage_5
	
Checking if core install stage - setup_SMF_scripts is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - setup_SMF_scripts
	
Checking if core install stage - setup_SMF_scripts is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully installed Service scripts
	
Checking if core install stage - validate_SMF_contracts is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering core install stage - validate_SMF_contracts
	
Checking if core install stage - validate_SMF_contracts is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully validated SMF manifest files
	
Checking if rep_stage_5 stage is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - rep_stage_5
	
Checking if Linux replacement stage - post_configuration is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - post_configuration
	
Checking if Linux replacement stage - post_configuration is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - post_configuration
	
Checking if Linux replacement stage - cleanup_replacement is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Entering Linux replacement stage - cleanup_replacement
	
Checking if Linux replacement stage - cleanup_replacement is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed - cleanup_replacement
	
Checking if Post Replacement is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 scheduler is running OK
	
Checking if Post Replacement is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed Procedure to check all loads work properly
	
Checking if CleanUp is successfully started
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Starting cleanup activity
	
Checking if CleanUp is successfully completed
    [Tags]             Blade  Replacement
    Should Contain     ${Replacement}                 Successfully completed Procedure to clean temporary files/directories
