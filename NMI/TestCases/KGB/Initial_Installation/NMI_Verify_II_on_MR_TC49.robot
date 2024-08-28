*** Settings ***
Library    OperatingSystem
Library    String

*** Variables ***

*** Test Cases ***
Checking if stage list is successfully built on coordinator
    [Tags]                  II  MR-Coordinator
    ${II-MR-CO}=            Get File                   II-MR-Coordinator.log
    Set Global Variable     ${II-MR-CO}
    Should Contain          ${II-MR-CO}                 Building stage list from /eniq/installation/core_install/etc/stats_stats_coordinator_stagelist

Checking if stage - allow_root_access is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - get_storage_type

Checking if storage type is successfully set on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - update_netmasks_file

Checking if stage - update_netmasks_file is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully updated /etc/inet/netmasks file

Checking if stage - configure_storage_api is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - build_ini_file

Checking if ini files are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed NASd

Checking if stage - delete_nas_filesystems is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - delete_nas_filesystems

Checking if filesystems on NAS are successfully deleted on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully deleted filesystems on NAS

Checking if stage - create_nas_filesystems is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_nas_filesystems

Checking fs creation - sybase_iq on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 sybase_iq

Checking if stage - create_nas_shares is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_nas_shares

Checking if install stage - create_volume_group is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_volume_group

Checking if volume group stats_coordinator_pool is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 volume group stats_coordinator_pool created

Checking if install stage - create_logical_volume_filesystem is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_coordinator_pool-rep_main filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-rep_main filesystem

Checking if fileSystem stats_coordinator_pool-rep_main is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-rep_main

Checking if /etc/fstab file with filesystem stats_coordinator_pool-rep_main is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-rep_main

Checking if stats_coordinator_pool-rep_temp filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-rep_temp filesystem

Checking if fileSystem stats_coordinator_pool-rep_temp is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_coordinator_pool-rep_temp is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-rep_temp

Checking if stats_coordinator_pool-dwh_main filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-dwh_main filesystem

Checking if fileSystem stats_coordinator_pool-dwh_main is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_main is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_main

Checking if stats_coordinator_pool-dwh_reader filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-dwh_reader filesystem

Checking if fileSystem stats_coordinator_pool-dwh_reader is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_reader is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_reader

Checking if stats_coordinator_pool-dwh_main_dbspace filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_coordinator_pool-dwh_main_dbspace is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_main_dbspace is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_main_dbspace

Checking if stats_coordinator_pool-dwh_temp_dbspace filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_coordinator_pool-dwh_temp_dbspace is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_temp_dbspace is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_temp_dbspace

Checking if stats_coordinator_pool-misc is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-misc

Checking if fileSystem stats_coordinator_pool-misc is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-misc

Checking if /etc/fstab file with filesystem stats_coordinator_pool-misc is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-misc

Checking if stats_coordinator_pool-bkup_sw filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-bkup_sw filesystem

Checking if fileSystem stats_coordinator_pool-bkup_sw is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_coordinator_pool-bkup_sw is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-bkup_sw

Checking if stats_coordinator_pool-connectd filesystem is successfully removed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Removing the stats_coordinator_pool-connectd filesystem

Checking if fileSystem stats_coordinator_pool-connectd is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating fileSystem stats_coordinator_pool-connectd

Checking if /etc/fstab file with filesystem stats_coordinator_pool-connectd is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-connectd

Checking if FS filesystems are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating group dc5000

Checking if groups are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created groups

Checking if stage - create_users is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking ssh keys for dcuser are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating ssh keys for dcuser

Checking if /eniq/home/dcuser/.ssh is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating /eniq/home/dcuser/.ssh

Checking if ownership of /eniq/home/dcuser/.ssh to dcuser is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/home/dcuser/.ssh to dcuser

Checking if ownership of /eniq/home/dcuser/.ssh/id_rsa to dcuser is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/home/dcuser/.ssh/id_rsa to dcuser

Checking if ownership of /eniq/home/dcuser/.ssh/id_rsa.pub to dcuser is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/home/dcuser/.ssh/id_rsa.pub to dcuser

Checking if /eniq/home/dcuser/.ssh/authorized_keys file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /eniq/home/dcuser/.ssh/authorized_keys file

Checking if users are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created users
	
Checking if stage - relocate_sentinel is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - relocate_sentinel
	
Checking if files from /var/tmp/sentinel to /eniq/sentinel are successfully copied on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Copying files from /var/tmp/sentinel to /eniq/sentinel
	
Checking if /eniq/sentinel is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Recreating /eniq/sentinel
	
Checking if migration to NAS is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully migrated to NAS
	
Checking if stage - create_directories is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_directories
	
Checking if required directories are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created required directories
	
Checking if filesystem stats_coordinator_pool-rep_main ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-rep_main permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-rep_main permissions to 0755
	
Checking if filesystem stats_coordinator_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-rep_temp permissions to 1755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_coordinator_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_main permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_coordinator_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_reader permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_coordinator_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_main_dbspace permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_coordinator_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_coordinator_pool-misc ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-misc permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-misc permissions to 0755
	
Checking if filesystem stats_coordinator_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-bkup_sw permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_coordinator_pool-connectd ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing filesystem stats_coordinator_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_coordinator_pool-connectd permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing fileSystem stats_coordinator_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on coordinator 
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if irectory /eniq/database/dwh_reader is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if stage - populate_nasd_config is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - populate_nasd_config
	
Checking if stage - populate_nasd_config is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed stage - populate_nasd_config
	
Checking if stage - change_mount_owners is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - change_mount_owners
	
Checking if directory permissions are successfully changed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully changed directory permissions
	
Checking if stage - install_host_syncd is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed hostsync unit file
	
Checking if hostsync unit is successfully loaded on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed hostsyncd
	
Checking if stage - install_connectd_sw is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_connectd_sw
	
Checking if SW to /eniq/connectd is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed SW to /eniq/connectd
	
Checking if stage - install_backup_sw is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_backup_sw
	
Checking if SW to /eniq/bkup_sw is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if stage - create_admin_dir is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - generate_keys
	
Checking if stage - generate_keys is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - generate_keys
	
Checking if stage - create_rbac_roles is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if OSS is successfully added on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Addition of OSS successful
	
Checking if the wtmp file is successfully nullified on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully updated ENIQ ENV file
	
Checking if stage - install_sybaseiq is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_sybaseiq
	
Checking if SYBASE IQ is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed SYBASE IQ
	
Checking if stage - install_sybase_asa is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_sybase_asa
	
Checking if SYBASE ASA is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed SYBASE ASA
	
Checking if stage - update_sysuser_file is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - update_sysuser_file
	
Checking if stage - update_sysuser_file is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - update_sysuser_file
	
Checking if stage - create_db_sym_links is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_db_sym_links
	
Checking if DB Sym Links is successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created DB Sym Links
	
Checking if stage - create_repdb is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_repdb
	
Checking if stage - create_repdb is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed stage - create_repdb
	
Checking if stage - create_dwhdb is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - create_dwhdb
	
Checking if stage - create_dwhdb is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed stage - create_dwhdb
	
Checking if stage - install_ENIQ_platform is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_ENIQ_platform
	
Checking if ENIQ Platform is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed ENIQ Platform
	
Checking if Features are successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed Features
	
Checking if stage - activate_ENIQ_features is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - activate_ENIQ_features
	
Checking if feature interfaces are successfully activated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully activated feature interfaces
	
Checking if stage - setup_SMF_scripts is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully installed Service scripts
	
Checking if stage - install_extra_fs is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
	
Checking if stage - install_extra_fs is successfully completed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - install_rolling_snapshot is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - install_rolling_snapshot
	
Checking if rolling snapshots are successfully created on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully created rolling snapshots
	
Checking if crontab is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Crontab updated successfully
	
Checking if stage - validate_SMF_contracts is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files are successfully validated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully validated SMF manifest files
	
Checking if stage - add_alias_details_to_service_names is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - add_alias_details_to_service_names
	
Checking if NAS alias information in /etc/hosts is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully updated NAS alias information in /etc/hosts
	
Checking if stage - cleanup is successfully entered on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Entering core install stage - cleanup
	
Checking if ENIQ status file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Successfully updated ENIQ status file
	
Checking if /eniq/admin/version/eniq_history file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 /eniq/admin/version/eniq_history file updated correctly
	
Checking if /eniq/admin/version/eniq_status file is successfully updated on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 /eniq/admin/version/eniq_status file updated correctly
	
Checking if ENIQ SW is successfully installed on coordinator
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  MR-Coordinator
    Should Contain     ${II-MR-CO}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]                     II  MR-Coordinator
    ${count}=	    	       Get Count	      ${II-MR-CO}			tomcat_users_history.properties: No such file or directory
    Should Contain X Times     ${II-MR-CO}            No such file or directory		${count}

Checking if stage list is successfully built on engine
    [Tags]                 II  MR-Engine
    ${II-MR-Eng}=          Get File                   II-MR-Engine.log
    Set Global Variable    ${II-MR-Eng}
    Should Contain         ${II-MR-Eng}                 Building stage list from /eniq/installation/core_install/etc/stats_stats_engine_stagelist

Checking if stage - allow_root_access is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - get_storage_type

Checking if storage type is set successfully set on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - update_netmasks_file

Checking if /etc/inet/netmasks file is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully updated /etc/inet/netmasks file

Checking if stage - configure_storage_api is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - build_ini_file

Checking if ini files are successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed NASd

Checking if install stage - create_volume_group is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_volume_group

Checking if install stage - create_logical_volume_filesystem is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_engine_pool-rep_main filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-rep_main filesystem

Checking if fileSystem stats_engine_pool-rep_main is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-rep_main

Checking if /etc/fstab file with filesystem stats_engine_pool-rep_main is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-rep_main

Checking if stats_engine_pool-rep_temp filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-rep_temp filesystem

Checking if fileSystem stats_engine_pool-rep_temp is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_engine_pool-rep_temp is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-rep_temp

Checking if stats_engine_pool-dwh_main filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-dwh_main filesystem

Checking if fileSystem stats_engine_pool-dwh_main is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_main is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_main

Checking if stats_engine_pool-dwh_reader filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-dwh_reader filesystem

Checking if fileSystem stats_engine_pool-dwh_reader is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_reader is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_reader

Checking if stats_engine_pool-dwh_main_dbspace filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_engine_pool-dwh_main_dbspace is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_main_dbspace is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_main_dbspace

Checking if stats_engine_pool-dwh_temp_dbspace filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_engine_pool-dwh_temp_dbspace is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_temp_dbspace is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_temp_dbspace

Checking if stats_engine_pool-misc filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-misc filesystem

Checking if fileSystem stats_engine_pool-misc is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-misc

Checking if /etc/fstab file with filesystem stats_engine_pool-misc is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-misc

Checking if stats_engine_pool-bkup_sw filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-bkup_sw filesystem

Checking if fileSystem stats_engine_pool-bkup_sw is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_engine_pool-bkup_sw is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-bkup_sw

Checking if stats_engine_pool-connectd filesystem is successfully removed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Removing the stats_engine_pool-connectd filesystem

Checking if fileSystem stats_engine_pool-connectd is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating fileSystem stats_engine_pool-connectd

Checking if /etc/fstab file with filesystem stats_engine_pool-connectd is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /etc/fstab file with filesystem stats_engine_pool-connectd

Checking if FS filesystems are successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating group dc5000

Checking if groups are successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created groups

Checking if stage - create_users is entered successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking if users are successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created users
	
Checking if stage - create_directories is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_directories
	
Checking if required directories are successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created required directories
	
Checking if filesystem stats_engine_pool-rep_main ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-rep_main permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-rep_main permissions to 0755
	
Checking if filesystem stats_engine_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-rep_temp permissions to 1755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_engine_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_main permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_engine_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_reader permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_engine_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_main_dbspace permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_engine_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_engine_pool-misc ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-misc permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-misc permissions to 0755
	
Checking if filesystem stats_engine_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-bkup_sw permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_engine_pool-connectd ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing filesystem stats_engine_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_engine_pool-connectd permissions to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing fileSystem stats_engine_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on engine on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if irectory /eniq/database/dwh_reader is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if stage - populate_nasd_config is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - populate_nasd_config
	
Checking if stage - populate_nasd_config is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed stage - populate_nasd_config
	
Checking if stage - change_mount_owners is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - change_mount_owners
	
Checking if directory permissions are successfully changed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully changed directory permissions
	
Checking if stage - install_host_syncd is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed hostsync unit file
	
Checking if hostsync unit is successfully loaded on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed hostsyncd
	
Checking if stage - install_connectd_sw is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_connectd_sw
	
Checking if SW to /eniq/connectd is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed SW to /eniq/connectd
	
Checking if stage - install_backup_sw is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_backup_sw
	
Checking if SW to /eniq/bkup_sw is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if stage - create_admin_dir is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - generate_keys
	
Checking if stage - generate_keys is successfully skipped on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Non-coordinator install - skipping core install stage - generate_keys
	
Checking if stage - create_rbac_roles is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if the wtmp file is successfully nullified on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully updated ENIQ ENV file
	
Checking if stage - update_sysuser_file is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - update_sysuser_file
	
Checking if stage - update_sysuser_file is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed core install stage - update_sysuser_file
	
Checking if stage - setup_SMF_scripts is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully installed Service scripts
	
Checking if stage - install_extra_fs is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
	
Checking if stage - install_extra_fs is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - install_rolling_snapshot is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - install_rolling_snapshot
	
Checking if rolling snapshots are successfully created on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully created rolling snapshots
	
Checking if crontab is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Crontab updated successfully
	
Checking if stage - validate_SMF_contracts is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files are successfully validated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully validated SMF manifest files
	
Checking if stage - add_alias_details_to_service_names is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - add_alias_details_to_service_names
	
Checking if NAS alias information in /etc/hosts is successfully updated on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully updated NAS alias information in /etc/hosts
	
Checking if stage - cleanup is successfully entered on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Entering core install stage - cleanup
	
Checking if ENIQ cleanup stage is successfully completed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Successfully completed ENIQ cleanup stage
	
Checking if ENIQ SW is successfully installed on engine
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  MR-Engine
    Should Contain     ${II-MR-Eng}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]             II  MR-Engine
    Should Not Contain    ${II-MR-Eng}                 No such file or directory

Checking if stage list is successfully built on Reader1
    [Tags]                 II  Reader1
    ${II-MR-R1}=           Get File                II-MR-Reader1.log
    Set Global Variable    ${II-MR-R1}
    Should Contain         ${II-MR-R1}             Building stage list from /eniq/installation/core_install/etc/stats_stats_iqr_stagelist

Checking if stage - allow_root_access is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - get_storage_type

Checking if storage type is set successfully set on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - update_netmasks_file

Checking if /etc/inet/netmasks file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully updated /etc/inet/netmasks file

Checking if stage - configure_storage_api is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - build_ini_file

Checking if ini files are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed NASd

Checking if install stage - create_volume_group is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_volume_group

Checking if volume group stats_iqr_pool is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 volume group stats_iqr_pool created

Checking if install stage - create_logical_volume_filesystem is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_iqr_pool-rep_main filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-rep_main filesystem

Checking if fileSystem stats_iqr_pool-rep_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-rep_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_main is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_main

Checking if stats_iqr_pool-rep_temp filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-rep_temp filesystem

Checking if fileSystem stats_iqr_pool-rep_temp is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_temp is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_temp

Checking if stats_iqr_pool-dwh_main filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-dwh_main filesystem

Checking if fileSystem stats_iqr_pool-dwh_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main

Checking if stats_iqr_pool-dwh_reader filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-dwh_reader filesystem

Checking if fileSystem stats_iqr_pool-dwh_reader is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_reader is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_reader

Checking if stats_iqr_pool-dwh_main_dbspace filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_main_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace

Checking if stats_iqr_pool-dwh_temp_dbspace filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace

Checking if stats_iqr_pool-misc filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-misc filesystem

Checking if fileSystem stats_iqr_pool-misc is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-misc

Checking if /etc/fstab file with filesystem stats_iqr_pool-misc is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-misc

Checking if stats_iqr_pool-bkup_sw filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-bkup_sw filesystem

Checking if fileSystem stats_iqr_pool-bkup_sw is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_iqr_pool-bkup_sw is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-bkup_sw

Checking if stats_iqr_pool-connectd filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Removing the stats_iqr_pool-connectd filesystem

Checking if fileSystem stats_iqr_pool-connectd is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating fileSystem stats_iqr_pool-connectd

Checking if /etc/fstab file with filesystem stats_iqr_pool-connectd is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /etc/fstab file with filesystem stats_iqr_pool-connectd

Checking if FS filesystems are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating group dc5000

Checking if groups are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created groups

Checking if stage - create_users is entered successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking if users are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created users
	
Checking if stage - create_directories is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_directories
	
Checking if required directories are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created required directories
	
Checking if filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_main permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-rep_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_temp permissions to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_reader permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_iqr_pool-misc ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-misc permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-misc permissions to 0755
	
Checking if filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-bkup_sw permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_iqr_pool-connectd permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing fileSystem stats_iqr_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on Reader1 
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if irectory /eniq/database/dwh_reader is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if stage - populate_nasd_config is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - populate_nasd_config
	
Checking if stage - populate_nasd_config is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed stage - populate_nasd_config
	
Checking if stage - change_mount_owners is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - change_mount_owners
	
Checking if directory permissions are successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully changed directory permissions
	
Checking if stage - install_host_syncd is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed hostsync unit file
	
Checking if hostsync unit is successfully loaded on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed hostsyncd
	
Checking if stage - install_connectd_sw is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_connectd_sw
	
Checking if SW to /eniq/connectd is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed SW to /eniq/connectd
	
Checking if stage - install_backup_sw is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_backup_sw
	
Checking if SW to /eniq/bkup_sw is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if stage - create_admin_dir is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - generate_keys
	
Checking if stage - generate_keys is successfully skipped on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Non-coordinator install - skipping core install stage - generate_keys
	
Checking if stage - create_rbac_roles is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if the wtmp file is successfully nullified on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully updated ENIQ ENV file

Checking if stage - update_sysuser_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - update_sysuser_file
	
Checking if stage - update_sysuser_file is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed core install stage - update_sysuser_file
	
Checking if stage - create_db_sym_links is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - create_db_sym_links
	
Checking if DB Sym Links is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created DB Sym Links
	
Checking if stage - setup_SMF_scripts is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully installed Service scripts
	
Checking if stage - install_extra_fs is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
	
Checking if stage - install_extra_fs is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - install_rolling_snapshot is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - install_rolling_snapshot
	
Checking if rolling snapshots are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully created rolling snapshots
	
Checking if crontab is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Crontab updated successfully
	
Checking if stage - validate_SMF_contracts is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files are successfully validated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully validated SMF manifest files
	
Checking if stage - add_alias_details_to_service_names is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - add_alias_details_to_service_names
	
Checking if NAS alias information in /etc/hosts is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully updated NAS alias information in /etc/hosts
	
Checking if stage - cleanup is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Entering core install stage - cleanup
	
Checking if ENIQ cleanup stage is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Successfully completed ENIQ cleanup stage

Checking if ENIQ SW is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  Reader1
    Should Contain     ${II-MR-R1}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]             II  Reader1
    Should Not Contain    ${II-MR-R1}                 No such file or directory

Checking if stage list is successfully built on Reader2
    [Tags]                 II  Reader2
    ${II-MR-R2}=           Get File                   II-MR-Reader2.log
	Set Global Variable    ${II-MR-R2}
    Should Contain         ${II-MR-R2}                 Building stage list from /eniq/installation/core_install/etc/stats_stats_iqr_stagelist

Checking if stage - allow_root_access is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - get_storage_type

Checking if storage type is set successfully set on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on Reader2
    [Tags]                 II  Reader2
    ${II-MR-R2}=           Get File                II-MR-Reader2.log
    Should Contain         ${II-MR-R2}              Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - update_netmasks_file

Checking if /etc/inet/netmasks file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully updated /etc/inet/netmasks file

Checking if stage - configure_storage_api is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - build_ini_file

Checking if ini files are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed NASd

Checking if install stage - create_volume_group is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_volume_group

Checking if volume group stats_iqr_pool is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 volume group stats_iqr_pool created

Checking if install stage - create_logical_volume_filesystem is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_iqr_pool-rep_main filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-rep_main filesystem

Checking if fileSystem stats_iqr_pool-rep_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-rep_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_main is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_main

Checking if stats_iqr_pool-rep_temp filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-rep_temp filesystem

Checking if fileSystem stats_iqr_pool-rep_temp is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_temp is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_temp

Checking if stats_iqr_pool-dwh_main filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-dwh_main filesystem

Checking if fileSystem stats_iqr_pool-dwh_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main

Checking if stats_iqr_pool-dwh_reader filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-dwh_reader filesystem

Checking if fileSystem stats_iqr_pool-dwh_reader is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_reader is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_reader

Checking if stats_iqr_pool-dwh_main_dbspace filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_main_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace

Checking if stats_iqr_pool-dwh_temp_dbspace filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace

Checking if stats_iqr_pool-misc filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-misc filesystem

Checking if fileSystem stats_iqr_pool-misc is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-misc

Checking if /etc/fstab file with filesystem stats_iqr_pool-misc is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-misc

Checking if stats_iqr_pool-bkup_sw filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-bkup_sw filesystem

Checking if fileSystem stats_iqr_pool-bkup_sw is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_iqr_pool-bkup_sw is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-bkup_sw

Checking if stats_iqr_pool-connectd filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Removing the stats_iqr_pool-connectd filesystem

Checking if fileSystem stats_iqr_pool-connectd is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating fileSystem stats_iqr_pool-connectd

Checking if /etc/fstab file with filesystem stats_iqr_pool-connectd is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /etc/fstab file with filesystem stats_iqr_pool-connectd

Checking if FS filesystems are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating group dc5000

Checking if groups are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created groups

Checking if stage - create_users is entered successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking if users are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created users
	
Checking if stage - create_directories is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_directories
	
Checking if required directories are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created required directories
	
Checking if filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_main permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-rep_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_temp permissions to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_reader permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_iqr_pool-misc ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-misc permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-misc permissions to 0755
	
Checking if filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-bkup_sw permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_iqr_pool-connectd permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing fileSystem stats_iqr_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on Reader2 
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if irectory /eniq/database/dwh_reader is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if stage - populate_nasd_config is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - populate_nasd_config
	
Checking if stage - populate_nasd_config is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed stage - populate_nasd_config
	
Checking if stage - change_mount_owners is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - change_mount_owners
	
Checking if directory permissions are successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully changed directory permissions
	
Checking if stage - install_host_syncd is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed hostsync unit file
	
Checking if hostsync unit is successfully loaded on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed hostsyncd
	
Checking if stage - install_connectd_sw is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_connectd_sw
	
Checking if SW to /eniq/connectd is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed SW to /eniq/connectd
	
Checking if stage - install_backup_sw is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_backup_sw
	
Checking if SW to /eniq/bkup_sw is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if stage - create_admin_dir is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - generate_keys
	
Checking if stage - generate_keys is successfully skipped on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Non-coordinator install - skipping core install stage - generate_keys
	
Checking if stage - create_rbac_roles is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if the wtmp file is successfully nullified on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully updated ENIQ ENV file

Checking if stage - update_sysuser_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - update_sysuser_file
	
Checking if stage - update_sysuser_file is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed core install stage - update_sysuser_file
	
Checking if stage - create_db_sym_links is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - create_db_sym_links
	
Checking if DB Sym Links is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created DB Sym Links
	
Checking if stage - setup_SMF_scripts is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully installed Service scripts
	
Checking if stage - install_extra_fs is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
	
Checking if stage - install_extra_fs is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - install_rolling_snapshot is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - install_rolling_snapshot
	
Checking if rolling snapshots are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully created rolling snapshots
	
Checking if crontab is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Crontab updated successfully
	
Checking if stage - validate_SMF_contracts is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files are successfully validated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully validated SMF manifest files
	
Checking if stage - add_alias_details_to_service_names is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - add_alias_details_to_service_names
	
Checking if NAS alias information in /etc/hosts is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully updated NAS alias information in /etc/hosts
	
Checking if stage - cleanup is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Entering core install stage - cleanup
	
Checking if ENIQ cleanup stage is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Successfully completed ENIQ cleanup stage

Checking if ENIQ SW is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  Reader2
    Should Contain     ${II-MR-R2}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]             II  Reader2
    Should Not Contain    ${II-MR-R2}                 No such file or directory

