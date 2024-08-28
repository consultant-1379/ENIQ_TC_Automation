*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***

Checking if migration started successfully.
    [Tags]             Blade  Migration
    ${Blade_Migration}=    Get File                       Migration-SB.log
    Set Global Variable        ${Blade_Migration} 
    Should Contain     ${Blade_Migration}                 Starting to run continue_eniq_migration.bsh

Checking Migration Information from user
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Getting Migration Information from user
	
Checking if Migration started on Blade server
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Migration started on Blade server
	
Checking Available Interfaces
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Available Interfaces
	
Getting USER VALUE CONFIRMATION
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 USER VALUE CONFIRMATION
	
Checking if Migration Backup Information - backup server IP address is displayed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Migration backup server IP address
	
Checking if Migration Backup Information - Directory path of Migration backup is displayed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Directory path of Migration backup
	
Displaying New LUN ID Information.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 ID of the newly created LUN
	
Checking stage - copy_from_nas_backup is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering stage - copy_from_nas_backup
	
Checking stage - copy_from_nas_backup is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed stage - copy_from_nas_backup
	
Checking stage - update_merge_config_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering stage - update_merge_config_files
	
Checking stage - update_merge_config_files is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed stage - update_merge_config_files
	
Checking Linux Migration stage initiate_migration is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux Migration stage initiate_migration
	
Checking if migration activity is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Starting migration activity.
	
Entering procedure to migrate Linux OS.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Building stage list from /eniq/installation/core_install/etc/eniq_linux_migration_stagelist
	
Checking if Linux migration stage - install_san_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_san_sw
	
Checking if core install stage - install_san_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_san_sw
	
Checking if core install stage - install_san_sw is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed SAN SW
	
Checking if Linux migration stage - install_san_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_san_sw
	
Checking if Linux migration stage - install_storage_api is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_storage_api
	
Checking if core install stage - install_storage_api is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_storage_api
	
Checking if core install stage - install_storage_api is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed Storage API SW
	
Checking if Linux migration stage - install_storage_api is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_storage_api
	
Checking if Linux migration stage - configure_storage_api is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - configure_storage_api
	
Checking if Linux migration stage - configure_storage_api is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed Migration Stage - configure_storage_api
	
Checking if Linux migration stage - rescan_reboot is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - rescan_reboot
	
Checking if Linux migration stage - rescan_reboot is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - rescan_reboot
	
Checking if Linux migration stage - update_disk_partition is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - update_disk_partition
	
Checking if Linux migration stage - update_disk_partition is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - update_disk_partition
	
Checking if Linux migration stage - create_disk_partition_stats_pool is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_disk_partition_stats_pool
	
Checking if core install stage - create_disk_partition is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_disk_partition
	
Checking if core install stage - create_disk_partition is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created partitions over data disks
	
Checking if Linux migration stage - create_disk_partition_stats_pool is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_disk_partition_stats_pool
	
Checking if Linux migration stage - allow_root_access is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - allow_root_access
	
Checking if core install stage - allow_root_access is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - allow_root_access
	
Checking if core install stage - allow_root_access is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed core install stage - allow_root_access
	
Checking if Linux migration stage - allow_root_access is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - allow_root_access
	
Checking if Linux migration stage - get_update_server_netmask is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - get_update_server_netmask
	
Checking if Linux migration stage - get_update_server_netmask is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - get_update_server_netmask
	
Checking if Linux migration stage - update_netmasks_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - update_netmasks_file
	
Checking if core install stage - update_netmasks_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - update_netmasks_file
	
Checking if core install stage - update_netmasks_file is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed core install stage - update_netmasks_file
	
Checking if Linux migration stage - update_netmasks_file is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - update_netmasks_file
	
Checking if Linux migration stage - create_lun_map is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_lun_map
	
Checking if core install stage - create_lun_map is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created LUN Map ini file
	
Checking if Linux migration stage - create_lun_map is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_lun_map
	
Checking if Linux migration stage - install_nas_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_nas_sw
	
Checking if core install stage - install_nas_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_nas_sw
	
Checking if core install stage - install_nas_sw is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed NAS API
	
Checking if Linux migration stage - install_nas_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_nas_sw
	
Checking if Linux migration stage - create_nas_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_nas_users
	
Checking if core install stage - create_nas_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_nas_users
	
Checking if core install stage - create_nas_users is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed stage - create_nas_users
	
Checking if Linux migration stage - create_nas_users is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_nas_users
	
Checking if Linux migration stage - install_service_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_service_scripts
	
Checking if core install stage - install_service_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_service_scripts
	
Checking if core install stage - install_service_scripts is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed SW to /eniq/smf
	
Checking if Linux migration stage - install_service_scripts is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_service_scripts
	
Checking if Linux migration stage - install_nasd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_nasd
	
Checking if core install stage - install_nasd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_nasd
	
Checking if core install stage - install_nasd is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed NASd
	
Checking if Linux migration stage - install_nasd is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_nasd
	
Checking if Linux migration stage - merge_config_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - merge_config_files
	
Checking if Linux migration stage - merge_config_files is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - merge_config_files
	
Checking if Linux migration stage - setup_ipmp is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - setup_ipmp
	
Checking if Linux migration stage - setup_ipmp is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - setup_ipmp
	
Checking if Linux migration stage - update_dns_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - update_dns_files
	
Checking if core install stage - update_dns_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - update_dns_files
	
Checking if core install stage - update_dns_files is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully updated system DNS file(s)
	
Checking if Linux migration stage - update_dns_files is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - update_dns_files
	
Checking if Linux migration stage - update_timezone_info is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - update_timezone_info
	
Checking if core install stage - update_timezone_info is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - update_timezone_info
	
Checking if core install stage - update_timezone_info is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully updated Timezone Information
	
Checking if Linux migration stage - update_timezone_info is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - update_timezone_info
	
Checking if Linux migration stage - create_volume_group is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_volume_group
	
Checking if Linux migration stage - create_volume_group is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_volume_group
	
Checking if Linux migration stage - create_logical_volume_filesystem is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_logical_volume_filesystem
	
Checking if core install stage - create_logical_volume_filesystem is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_logical_volume_filesystem
	
Checking if core install stage - create_logical_volume_filesystem is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created FS filesystems
	
Checking if Linux migration stage - create_logical_volume_filesystem is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_logical_volume_filesystem
	
Checking if Linux migration stage - install_backup_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_backup_sw
	
Checking if core install stage - install_backup_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_backup_sw
	
Checking if core install stage - install_backup_sw is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if Linux migration stage - install_backup_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_backup_sw
	
Checking if Linux migration stage - install_connectd_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_connectd_sw
	
Checking if core install stage - install_connectd_sw is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_connectd_sw
	
Checking if core install stage - install_connectd_sw is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed SW to /eniq/connectd
	
Checking if Linux migration stage - install_connectd_sw is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_connectd_sw
	
Checking if Linux migration stage - create_groups is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_groups
	
Checking if core install stage - create_groups is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_groups
	
Checking if core install stage - create_groups is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created groups
	
Checking if Linux migration stage - create_groups is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_groups
	
Checking if Linux migration stage - create_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_users
	
Checking if core install stage - create_users is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_users
	
Checking if core install stage - create_users is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created users
	
Checking if Linux migration stage - create_users is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_users
	
Checking if Linux migration stage - migrate_sentinel is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - migrate_sentinel
	
Checking if core install stage - install_sentinel is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_sentinel
	
Checking if core install stage - install_sentinel is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed ENIQ Sentinel server
	
Checking if Linux migration stage - migrate_sentinel is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - migrate_sentinel
	
Checking if Linux migration stage - create_directories is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_directories
	
Checking if core install stage - create_directories is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_directories
	
Checking if core install stage - create_directories is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created required directories
	
Checking if Linux migration stage - create_directories is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_directories
	
Checking if Linux migration stage - populate_nasd_config is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - populate_nasd_config
	
Checking if core install stage - populate_nasd_config is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - populate_nasd_config
	
Checking if core install stage - populate_nasd_config is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed stage - populate_nasd_config
	
Checking if Linux migration stage - populate_nasd_config is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - populate_nasd_config
	
Checking if Linux migration stage - cleanup_old_nas_content is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - cleanup_old_nas_content
	
Checking if Linux migration stage - cleanup_old_nas_content is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - cleanup_old_nas_content
	
Checking if Linux migration stage - install_host_syncd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_host_syncd
	
Checking if core install stage - install_host_syncd is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed hostsyncd
	
Checking if Linux migration stage - install_host_syncd is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_host_syncd
	
Checking if Linux migration stage - create_admin_dir is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_admin_dir
	
Checking if core install stage - create_admin_dir is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_admin_dir
	
Checking if core install stage - create_admin_dir is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully populated /eniq/admin directory
	
Checking if Linux migration stage - create_admin_dir is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_admin_dir
	
Checking if Linux migration stage - generate_keys is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - generate_keys
	
Checking if core install stage - generate_keys is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - generate_keys
	
Checking if core install stage - generate_keys is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed core install stage - generate_keys
	
Checking if Linux migration stage - generate_keys is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - generate_keys
	
Checking if Linux migration stage - create_rbac_roles is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_rbac_roles
	
Checking if core install stage - create_rbac_roles is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed configuration for ENIQ user roles.
	
Checking if Linux migration stage - create_rbac_roles is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - create_rbac_roles
	
Checking if Linux migration stage - update_ENIQ_env_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - update_ENIQ_env_files
	
Checking if core install stage - update_ENIQ_env_files is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if core install stage - update_ENIQ_env_files is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully updated ENIQ ENV file
	
Checking if Linux migration stage - update_ENIQ_env_files is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - update_ENIQ_env_files
	
Checking if Linux migration stage - restore_databases is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - restore_databases
	
Checking if Linux migration stage - restore_databases is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - restore_databases
	
Checking if Linux migration stage - install_sap_asa_binaries is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_sap_asa_binaries
	
Checking if Linux migration stage - install_sap_asa_binaries is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_sap_asa_binaries
	
Checking if Linux migration stage - install_sap_iq_binaries is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_sap_iq_binaries
	
Checking if Linux migration stage - install_sap_iq_binaries is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_sap_iq_binaries
	
Checking if Linux migration stage - update_sysuser_file is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - update_sysuser_file
	
Checking if Linux migration stage - update_sysuser_file is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully updated home areas and profiles
	
Checking if Linux migration stage - register_raw_device is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - register_raw_device
	
Checking if Linux migration stage - register_raw_device is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - register_raw_device
	
Checking if Linux migration stage - recreate_db_symlinks is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - recreate_db_symlinks
	
Checking if core install stage - create_db_sym_links is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - create_db_sym_links
	
Checking if core install stage - create_db_sym_links is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created DB Sym Links
	
Checking if Linux migration stage - recreate_db_symlinks is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - recreate_db_symlinks
	
Checking if Linux migration stage - migrate_sap_asa is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - migrate_sap_asa
	
Checking if Linux migration stage - migrate_sap_asa is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - migrate_sap_asa
	
Checking if Linux migration stage - migrate_sap_iq is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - migrate_sap_iq
	
Checking if Linux migration stage - migrate_sap_iq is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - migrate_sap_iq
	
Checking if Linux migration stage - install_ENIQ_platform is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_ENIQ_platform
	
Checking if core install stage - install_ENIQ_platform is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_ENIQ_platform
	
Checking if core install stage - install_ENIQ_platform is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed ENIQ Platform
	
Checking if Linux migration stage - install_ENIQ_platform is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_ENIQ_platform
	
Checking if Linux migration stage - merge_platform_content is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - merge_platform_content
	
Checking if Linux migration stage - merge_platform_content is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - merge_platform_content
	
Checking if Linux migration stage - install_parser is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_parser
	
Checking if Linux migration stage - install_parser is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_parser
	
Checking if Linux migration stage - setup_SMF_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - setup_SMF_scripts
	
Checking if core install stage - setup_SMF_scripts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - setup_SMF_scripts
	
Checking if core install stage - setup_SMF_scripts is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully installed Service scripts
	
Checking if Linux migration stage - setup_SMF_scripts is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - setup_SMF_scripts
	
Checking if Linux migration stage - install_extra_fs is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_extra_fs
	
Checking if core install stage - install_extra_fs is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_extra_fs
	
Checking if core install stage - install_extra_fs is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed core install stage - install_extra_fs
	
Checking if Linux migration stage - install_extra_fs is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_extra_fs
	
Checking if Linux migration stage - install_rolling_snapshot is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - install_rolling_snapshot
	
Checking if core install stage - install_rolling_snapshot is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - install_rolling_snapshot
	
Checking if core install stage - install_rolling_snapshot is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully created rolling snapshots
	
Checking if Linux migration stage - install_rolling_snapshot is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - install_rolling_snapshot
	
Checking if Linux migration stage - validate_SMF_contracts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - validate_SMF_contracts
	
Checking if core install stage - validate_SMF_contracts is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering core install stage - validate_SMF_contracts
	
Checking if core install stage - validate_SMF_contracts is successfully completed
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully validated SMF manifest files
	
Checking if Linux migration stage - validate_SMF_contracts is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - validate_SMF_contracts
	
Checking if Linux migration stage - post_configuration is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - post_configuration
	
Checking if Linux migration stage - post_configuration is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - post_configuration

Checking if Linux migration stage - cleanup_migration is successfully started.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Entering Linux migration stage - cleanup_migration
	
Checking if Linux migration stage - cleanup_migration is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed - cleanup_migration
	
Checking if Migration is successfully completed.
    [Tags]             Blade  Migration    
    Should Contain     ${Blade_Migration}                 Successfully completed OS Migration on Linux
