*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Getting Replacement Information from User
    [Tags]             Rack  Replacement
    ${Faulty-Rack}=    Get File                       Faulty-Rack-Replacement.log
    Set Global Variable        ${Faulty-Rack}    
    Should Contain     ${Faulty-Rack}                 Getting Replacement Information from User

Checking if install_emc_pkg stage is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Replacement Stage - install_emc_pkg
	
Checking if install_emc_pkg stage is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed Replacement Stage - install_emc_pkg
	
Checking if configure_stor_api stage is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Replacement Stage - configure_stor_api
	
Checking if configure_stor_api stage is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed Replacement Stage - configure_stor_api
	
Checking if Linux Replacement stage start_replacement is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux Replacement stage start_replacement
	
Starting to execute Replacement
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Starting to execute Replacement using command
	
Entering Procedure for Linux Blade Replacement.
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Procedure for Linux Blade Replacement.
	
Checking if Linux replacement stage - rep_stage_2 is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - rep_stage_2
	
Checking if core install stage - setup_ipmp is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - setup_ipmp
	
Checking if core install stage - setup_ipmp is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully setup bond
	
Checking if core install stage - update_netmasks_file is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - update_netmasks_file
	
Checking if core install stage - update_netmasks_file is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed core install stage - update_netmasks_file
	
Checking if core install stage - create_lun_map is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully created LUN Map ini file
	
Checking if rep_stage_2 stage is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed - rep_stage_2
	
Checking if Linux replacement stage - rep_stage_3 is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - rep_stage_3
	
Checking if core install stage - update_system_file is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - update_system_file
	
Checking if core install stage - update_system_file is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed core install stage - update_system_file
	
Checking if core install stage - update_defaultrouter_file is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - update_defaultrouter_file
	
Checking if core install stage - update_defaultrouter_file is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully updated /etc/sysconfig/network file
	
Checking if core install stage - install_nasd is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - install_nasd
	
Checking if NASd is successfully installed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully installed NASd
	
Checking if rep_stage_3 stage is successfully completed
    [Tags]             Rack  Replacement   
    Should Contain     ${Faulty-Rack}                 Successfully completed - rep_stage_3
	
Checking if Linux replacement stage - rep_stage_4 is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - rep_stage_4
	
Checking if core install stage - create_groups is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - create_groups
	
Checking if core install stage - create_groups is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully created groups
	
Checking if core install stage - create_users is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - create_users
	
Checking if core install stage - create_users is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully created users
	
Checking if core install stage - change_mount_owners is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - change_mount_owners
	
Checking if core install stage - change_mount_owners is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully changed directory permissions
	
Checking if core install stage - install_host_syncd is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully installed hostsyncd
	
Checking if core install stage - generate_keys is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - generate_keys
	
Checking if core install stage - create_rbac_roles is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed configuration for ENIQ user roles.
	
Checking if rep_stage_4 stage is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed - rep_stage_4
	
Checking if Linux replacement stage - repair_sym_links is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - repair_sym_links
	
Checking if core install stage - create_db_sym_links is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - create_db_sym_links
	
Checking if core install stage - create_db_sym_links is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully created DB Sym Links
	
Checking if Linux replacement stage - repair_sym_links stage is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed - repair_sym_links
	
Checking if Linux replacement stage - rep_stage_5 is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - rep_stage_5
	
Checking if core install stage - setup_SMF_scripts is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - setup_SMF_scripts
	
Checking if core install stage - setup_SMF_scripts is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully installed Service scripts
	
Checking if core install stage - validate_SMF_contracts is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering core install stage - validate_SMF_contracts
	
Checking if core install stage - validate_SMF_contracts is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully validated SMF manifest files
	
Checking if rep_stage_5 stage is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed - rep_stage_5
	
Checking if Linux replacement stage - post_configuration is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - post_configuration
	
Checking if Linux replacement stage - post_configuration is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed - post_configuration
	
Checking if Linux replacement stage - cleanup_replacement is successfully started
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Entering Linux replacement stage - cleanup_replacement
	
Checking if Linux replacement stage - cleanup_replacement is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed - cleanup_replacement
	
Checking if Procedure for Linux Blade Replacement. is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed Procedure for Linux Blade Replacement.
	
Checking if Replacement Stage - start_replacement is successfully completed
    [Tags]             Rack  Replacement    
    Should Contain     ${Faulty-Rack}                 Successfully completed Replacement Stage - start_replacement
