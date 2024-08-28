*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if prerecovery activity is successfully started
    [Tags]                         Blade-Replacement  Pre-Recovery
    ${Pre-Recovery-Blade}=         Get File                   Pre-Recovery-Blade.log
	Set Global Variable            ${Pre-Recovery-Blade}
    Should Contain                 ${Pre-Recovery-Blade}      Starting prerecovery activity

Checking if stage list is successfully build for pre-recovery
    [Tags]             Blade-Replacement  Pre-Recovery
    Should Contain     ${Pre-Recovery-Blade}      Building stage list from /eniq/installation/core_install/etc/stats_eniq_stats_stagelist
	
Checking if populate_nasd_config stage is successfully started
    [Tags]             Blade-Replacement  Pre-Recovery
    Should Contain     ${Pre-Recovery-Blade}      Entering core install stage - populate_nasd_config
	
Checking if populate_nasd_config stage is successfully completed
    [Tags]             Blade-Replacement  Pre-Recovery
    Should Contain     ${Pre-Recovery-Blade}      Successfully completed stage - populate_nasd_config
	
Checking if volume groups are exported during prerecovery
    [Tags]             Blade-Replacement  Pre-Recovery
    Should Contain     ${Pre-Recovery-Blade}      Exporting volume group during prerecovery
	
Checking if Volume Group have been exported successfully.
    [Tags]             Blade-Replacement  Pre-Recovery
    Should Contain     ${Pre-Recovery-Blade}      Volume Group have been exported successfully.
	
Checking if Preparation phase for Linux Replacement Recovery is successfully completed
    [Tags]             Blade-Replacement  Pre-Recovery
    Should Contain     ${Pre-Recovery-Blade}      Successfully completed Preparation phase for Linux Replacement Recovery
	
Checking if Procedure to recover Linux Replacement Recovery is successfully started
    [Tags]                    Blade-Replacement  Recovery
    ${Recovery-Blade}=        Get File                   Recovery-Blade.log
	Set Global Variable       ${Recovery-Blade}
    Should Contain            ${Recovery-Blade}          Entering Procedure to recover Linux Replacement Recovery.

Checking if stage list is successfully build for recovery
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Building stage list from /eniq/installation/core_install/etc/eniq_linux_rep-recovery_stagelist

Checking if Linux rep-recovery stage - recreate_eniq_structure is successfully started
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - recreate_eniq_structure
	
Checking if Linux rep-recovery stage - recreate_eniq_structure is successfully completed
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Successfully completed - recreate_eniq_structure
	
Checking if Linux rep-recovery stage - rep_stage_1 is successfully started
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - rep_stage_1
	
Checking if core install stage - allow_root_access is successfully started
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Entering core install stage - allow_root_access
	
Checking if core install stage - allow_root_access is successfully completed
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Successfully completed core install stage - allow_root_access
	
Checking if Linux rep-recovery stage - rep_stage_1 is successfully completed
    [Tags]             Blade-Replacement  Recovery
    Should Contain     ${Recovery-Blade}          Successfully completed - rep_stage_1
	
Checking if Linux rep-recovery stage - rep_stage_2 is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - rep_stage_2
	
Checking if core install stage - setup_ipmp is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - setup_ipmp
	
Checking if core install stage - setup_ipmp is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully setup bond
	
Checking if core install stage - update_netmasks_file is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - update_netmasks_file
	
Checking if core install stage - update_netmasks_file is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed core install stage - update_netmasks_file
	
Checking if core install stage - create_lun_map is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully created LUN Map ini file

Checking if core install stage - install_nas_sw is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - install_nas_sw
	
Checking if core install stage - install_nas_sw is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully installed NAS API
	
Checking if core install stage - create_nas_users is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - create_nas_users
	
Checking if core install stage - create_nas_users is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed stage - create_nas_users

Checking if Linux rep-recovery stage - rep_stage_2 is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - rep_stage_2
	
Checking if Linux rep-recovery stage - rep_stage_3 is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - rep_stage_3
	
	
Checking if core install stage - update_system_file is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - update_system_file
	
Checking if core install stage - update_system_file is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed core install stage - update_system_file
	
Checking if core install stage - update_defaultrouter_file is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - update_defaultrouter_file
	
Checking if core install stage - update_defaultrouter_file is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully Completed core install stage - update_defaultrouter_file
	
Checking if Linux rep-recovery stage - rep_stage_3 is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - rep_stage_3
	
Checking if Linux rep-recovery stage - rep_stage_4 is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - rep_stage_4
	
Checking if core install stage - create_groups is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - create_groups
	
Checking if core install stage - create_groups is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed core install stage - create_groups
	
Checking if core install stage - create_users is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - create_users
	
Checking if core install stage - create_users is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed core install stage - create_users
	
Checking if core install stage - change_mount_owners is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - change_mount_owners
	
Checking if core install stage - change_mount_owners is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully changed directory permissions
	
Checking if core install stage - install_host_syncd is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully installed hostsyncd
	
Checking if core install stage - generate_keys is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - generate_keys
	
Checking if core install stage - generate_keys is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed core install stage - generate_keys
	
Checking if core install stage - create_rbac_roles is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed configuration for ENIQ user roles.
	
Checking if rep_stage_4 stage is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - rep_stage_4
	
Checking if Linux replacement stage - repair_sym_links is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - repair_sym_links
	
Checking if core install stage - create_db_sym_links is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - create_db_sym_links
	
Checking if core install stage - create_db_sym_links is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully created DB Sym Links
	
Checking if Linux replacement stage - repair_sym_links stage is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - repair_sym_links
	
Checking if Linux replacement stage - rep_stage_5 is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - rep_stage_5
	
Checking if core install stage - setup_SMF_scripts is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - setup_SMF_scripts
	
Checking if core install stage - setup_SMF_scripts is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully installed Service scripts
	
Checking if core install stage - validate_SMF_contracts is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering core install stage - validate_SMF_contracts
	
Checking if core install stage - validate_SMF_contracts is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully validated SMF manifest files
	
Checking if rep_stage_5 stage is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - rep_stage_5
	
Checking if Linux rep-recovery stage - post_configuration is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - post_configuration
	
Checking if Linux rep-recovery stage - post_configuration is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - post_configuration
	
Checking if Linux rep-recovery stage - recovery_cleanup is successfully started
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Entering Linux rep-recovery stage - recovery_cleanup
	
Checking if Linux rep-recovery stage - recovery_cleanup is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed - recovery_cleanup
	
Checking if Procedure to recover Linux Replacement Recovery is successfully completed
    [Tags]             Blade-Replacement  Recovery 
    Should Contain     ${Recovery-Blade}          Successfully completed Procedure to recover Linux Replacement Recovery.
