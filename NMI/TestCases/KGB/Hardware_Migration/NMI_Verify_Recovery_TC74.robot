*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Checking if migration started successfully.
    [Tags]             Blade  Migration
    ${recovery_Migration}=    Get File                       Recovery.log
    Set Global Variable        ${recovery_migration} 
    Should Contain     ${recovery_migration}                 Starting to run continue_eniq_recovery.bsh on
	
Checking stage - copy_from_nas_backup is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering stage - copy_from_nas_backup
	
Checking stage - copy_from_nas_backup is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - copy_from_nas_backup
	
Checking if stage - install_san_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering stage - install_san_sw
	
Checking if core install stage - install_san_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - install_san_sw
	
Checking if core install stage - install_san_sw is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully installed SAN SW
	
Checking if stage - install_san_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - install_san_sw
	
Checking if stage - install_storage_api is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering stage - install_storage_api
	
Checking if core install stage - install_storage_api is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully updated Storage API SW
	
Checking if stage - install_storage_api is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - install_storage_api
	
Checking if stage - configure_storage_api is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering  stage - configure_storage_api
	
Checking if stage - configure_storage_api is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - configure_storage_api
	
Checking if stage - enable_mpxio is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering  stage - enable_mpxio
	
Checking if stage - enable_mpxio is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - enable_mpxio
	
Checking if All the stage od contnue_eniq_recovery is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 All stages of continue_eniq_recovery are successfully completed
	
Checking if recovery activity is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Starting recovery activity.
	
Entering procedure to recover Linux OS.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Building stage list from /var/tmp/upgrade/Linux_Migration/core_install/etc/eniq_linux_recovery_stagelist
	
Checking if recovery stage - allow_root_access is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - allow_root_access
	
Checking if core install stage - allow_root_access is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - allow_root_access
	
Checking if core install stage - allow_root_access is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed core install stage - allow_root_access
	
Checking if recovery stage - allow_root_access is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - allow_root_access
	
Checking if recovery stage - setup_ipmp is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - setup_ipmp
	
Checking if core install stage - setup_ipmp is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - setup_ipmp
	
Checking if core install stage - setup_ipmp is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully setup IPMP
	
Checking if recovery stage - setup_ipmp is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - setup_ipmp
	
Checking if recovery stage - update_netmasks_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_netmasks_file
	
Checking if recovery stage - update_netmasks_file is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_netmasks_file
	
Checking if recovery stage - create_lun_map is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created LUN Map ini file
	
Checking if recovery stage - create_lun_map is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_lun_map
	
Checking if recovery stage - install_nas_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_nas_sw
	
Checking if core install stage - install_nas_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - install_nas_sw
	
Checking if core install stage - install_nas_sw is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully installed NAS API
	
Checking if recovery stage - install_nas_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_nas_sw
	
Checking if recovery stage - create_nas_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_nas_users
	
Checking if core install stage - create_nas_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_nas_users
	
Checking if core install stage - create_nas_users is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - create_nas_users
	
Checking if recovery stage - create_nas_users is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_nas_users
	
Checking if recovery stage - install_service_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_service_scripts
	
Checking if core install stage - install_service_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - install_service_scripts
	
Checking if core install stage - install_service_scripts is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully installed SW to /eniq/smf
	
Checking if recovery stage - install_service_scripts is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_service_scripts
	
Checking if recovery stage - update_system_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_system_file
	
Checking if core install stage - update_system_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - update_system_file
	
Checking if core install stage - update_system_file is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully updated /etc/system
	
Checking if recovery stage - update_system_file is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_system_file
	
Checking if recovery stage - update_defaultrouter_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_defaultrouter_file
	
Checking if core install stage - update_defaultrouter_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - update_defaultrouter_file
	
Checking if recovery stage - update_defaultrouter_file is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_defaultrouter_file
	
Checking if recovery stage - update_dns_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_dns_files
	
Checking if core install stage - update_dns_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - update_dns_files
	
Checking if core install stage - update_dns_files is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully updated system DNS file(s)
	
Checking if recovery stage - update_dns_files is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_dns_files
	
Checking if recovery stage - update_timezone_info is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_timezone_info
	
Checking if core install stage - update_timezone_info is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - update_timezone_info
	
Checking if core install stage - update_timezone_info is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully updated Timezone Information
	
Checking if recovery stage - update_timezone_info is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_timezone_info
	
Checking if recovery stage - install_nasd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_nasd
	
Checking if core install stage - install_nasd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - install_nasd
	
Checking if core install stage - install_nasd is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully installed NASd
	
Checking if recovery stage - install_nasd is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_nasd
	
Checking if recovery stage - update_ini_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_ini_file
	
Checking if recovery stage - update_ini_file is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_ini_file
	
Checking if recovery stage - create_zfs_pool is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_zfs_pool
	
Checking if core install stage - create_zfs_pool is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_zfs_pool
	
Checking if core install stage - create_zfs_pool is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created ZFS Storage Pool(s)
	
Checking if recovery stage - create_zfs_pool is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_zfs_pool
	
Checking if recovery stage - create_zfs_filesystem is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_zfs_filesystem
	
Checking if core install stage - create_zfs_filesystem is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_zfs_filesystem
	
Checking if core install stage - create_zfs_filesystem is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created ZFS filesystems
	
Checking if recovery stage - create_zfs_filesystem is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_zfs_filesystem
	
Checking if recovery stage - install_connectd_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_connectd_sw
	
Checking if recovery stage - install_connectd_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_connectd_sw
	
Checking if recovery stage - install_backup_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_backup_sw
	
Checking if recovery stage - install_backup_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_backup_sw
	
Checking if recovery stage - create_groups is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_groups
	
Checking if core install stage - create_groups is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_groups
	
Checking if core install stage - create_groups is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created groups
	
Checking if recovery stage - create_groups is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_groups
	
Checking if recovery stage - create_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering Linux recovery stage - create_users
	
Checking if core install stage - create_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_users
	
Checking if core install stage - create_users is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created users
	
Checking if recovery stage - create_users is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_users
	
Checking if recovery stage - create_directories is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_directories
	
Checking if core install stage - create_directories is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_directories
	
Checking if core install stage - create_directories is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created required directories
	
Checking if recovery stage - create_directories is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_directories
	
Checking if recovery stage - populate_nasd_config is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - populate_nasd_config
	
Checking if core install stage - populate_nasd_config is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - populate_nasd_config
	
Checking if core install stage - populate_nasd_config is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed stage - populate_nasd_config
	
Checking if recovery stage - populate_nasd_config is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - populate_nasd_config
	
Checking if recovery stage - change_mount_owners is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - change_mount_owners
	
Checking if core install stage - change_mount_owners is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - change_mount_owners
	
Checking if core install stage - change_mount_owners is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully changed directory permissions
	
Checking if recovery stage - change_mount_owners is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - change_mount_owners
	
Checking if recovery stage - install_host_syncd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully installed hostsyncd
	
Checking if recovery stage - install_host_syncd is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_host_syncd
	
Checking if recovery stage - create_admin_dir is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_admin_dir
	
Checking if core install stage - create_admin_dir is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_admin_dir
	
Checking if core install stage - create_admin_dir is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully populated /eniq/admin directory
	
Checking if recovery stage - create_admin_dir is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_admin_dir
	
Checking if recovery stage - generate_keys is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - generate_keys
	
Checking if core install stage - generate_keys is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - generate_keys
	
Checking if core install stage - generate_keys is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed core install stage - generate_keys
	
Checking if recovery stage - generate_keys is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - generate_keys
	
Checking if recovery stage - create_rbac_roles is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully added ENIQ RBAC roles
	
Checking if recovery stage - create_rbac_roles is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - create_rbac_roles
	
Checking if recovery stage - update_ENIQ_env_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - update_ENIQ_env_files
	
Checking if core install stage - update_ENIQ_env_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if core install stage - update_ENIQ_env_files is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully updated ENIQ ENV file
	
Checking if recovery stage - update_ENIQ_env_files is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - update_ENIQ_env_files
	
Checking if recovery stage - recover_nas is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recover_nas
	
Checking if recovery stage - recover_nas is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recover_nas
	
Checking if recovery stage - recover_sentinel is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recover_sentinel
	
Checking if recovery stage - recover_sentinel is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recover_sentinel
	
Checking if recovery stage - recreate_db_symlinks is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recreate_db_symlinks
	
Checking if core install stage - create_db_sym_links is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering core install stage - create_db_sym_links
	
Checking if core install stage - create_db_sym_links is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully created DB Sym Links
	
Checking if recovery stage - recreate_db_symlinks is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recreate_db_symlinks
	
Checking if recovery stage - recover_san is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recover_san
	
Checking if recovery stage - recover_san is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recover_san
	
Checking if recovery stage - recover_repdb is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recover_repdb
	
Checking if recovery stage - recover_repdb is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recover_repdb
	
Checking if recovery stage - recover_dwhdb is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recover_dwhdb
	
Checking if recovery stage - recover_dwhdb is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recover_dwhdb
	
Checking if recovery stage - setup_SMF_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - setup_SMF_scripts
	
Checking if recovery stage - setup_SMF_scripts is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - setup_SMF_scripts

Checking if recovery stage - install_extra_fs is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - install_extra_fs
	
Checking if recovery stage - install_extra_fs is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - install_extra_fs
	
Checking if recovery stage - validate_SMF_contracts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - validate_SMF_contracts
	
Checking if recovery stage - validate_SMF_contracts is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - validate_SMF_contracts
	
Checking if recovery stage - recovery_cleanup is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Entering recovery stage - recovery_cleanup
	
Checking if recovery stage - recovery_cleanup is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed - recovery_cleanup
	
Checking if recovery procedure is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${recovery_migration}                 Successfully completed procedure to recover Linux OS.
