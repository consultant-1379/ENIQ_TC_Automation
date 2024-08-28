*** Settings ***
Library    OperatingSystem
Library    String

*** Test Cases ***
Checking if stage list is successfully built on coordinator
    [Tags]             II  MB-Coordinator
    ${II_CO_Log}=      Get File                     II-MB-Coordinator.log
    Set Global Variable      ${II_CO_Log}
    Should Contain     ${II_CO_Log}                 Building stage list from /eniq/installation/core_install/etc/stats_stats_coordinator_stagelist

Checking if stage - allow_root_access is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - get_storage_type

Checking if storage type is successfully set on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - update_netmasks_file

Checking if stage - update_netmasks_file is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - update_netmasks_file

Checking if stage - configure_storage_api is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - build_ini_file

Checking if ssh connectivity for NAS is successfully setup on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Setting up ssh connectivity for NAS

Checking if ini files are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed NASd

Checking if stage - delete_nas_filesystems is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - delete_nas_filesystems

Checking if filesystems on NAS are successfully deleted on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully deleted filesystems on NAS

Checking if stage - create_nas_filesystems is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_nas_filesystems

Checking if NAS filesystems are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating NAS filesystems using values in /eniq/installation/config/storage.ini

Checking fs creation - admin on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 admin 2g
    
Checking fs creation - backup on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 backup 10g

Checking fs creation - etldata on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata 10g

Checking fs creation - archive on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 archive 8g

Checking fs creation - etldata_-00 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-00 10g

Checking fs creation - etldata_-01 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-01 10g

Checking fs creation - etldata_-02 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-02 10g

Checking fs creation - etldata_-03 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-03 10g

Checking fs creation - fmdata on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 fmdata 1g

Checking fs creation - home on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 home 10g

Checking fs creation - log on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 log 50g

Checking fs creation - pmdata on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 pmdata 5g

Checking fs creation - reference on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 reference 5g

Checking fs creation - rejected on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 rejected 10g
    
Checking fs creation - sentinel on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sentinel 1g

Checking fs creation - snapshot on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 snapshot 1g

Checking fs creation - sql_anywhere on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sql_anywhere 2g

Checking fs creation - sybase_iq on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sybase_iq

Checking fs creation - sw on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sw 6g

Checking fs creation - upgrade on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 upgrade 3g
    
Checking fs creation - pmdata_soem on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 pmdata_soem 1g
    
Checking fs creation - pmdata_sim on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 pmdata_sim 1g
    
Checking if filesystems on NAS are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created filesystems on NAS
    
Checking if stage - create_nas_shares is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_nas_shares
    
Checking if server is added as NAS client on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 as a client of NAS
    
Checking nfs share added - admin on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 admin with options rw,no_root_squash
                                  
Checking nfs share added - archive on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 archive with options rw,no_root_squash    

Checking nfs share added - backup on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 backup with options rw,no_root_squash

Checking nfs share added - etldata on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata with options rw,async,no_root_squash

Checking nfs share added - etldata_-01 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-01 with options rw,async,no_root_squash

Checking nfs share added - etldata_-02 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-02 with options rw,async,no_root_squash

Checking nfs share added - etldata_-03 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 etldata_-03 with options rw,async,no_root_squash

Checking nfs share added - fmdata on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 fmdata with options rw,no_root_squash

Checking nfs share added - home on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 home with options rw,no_root_squash

Checking nfs share added - log on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 log with options rw,no_root_squash

Checking nfs share added - pmdata on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 pmdata with options rw,no_root_squash

Checking nfs share added - reference on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 reference with options rw,no_root_squash

Checking nfs share added - rejected on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 rejected with options rw,no_root_squash

Checking nfs share added - sentinel on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sentinel with options rw,no_root_squash

Checking nfs share added - snapshot on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 snapshot with options rw,no_root_squash

Checking nfs share added - sql_anywhere on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sql_anywhere with options rw,no_root_squash

Checking nfs share added - sybase_iq on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sybase_iq with options rw,no_root_squash

Checking nfs share added - sw on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 sw with options rw,no_root_squash

Checking nfs share added - upgrade on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 upgrade with options rw,no_root_squash

Checking nfs share added - pmdata_soem on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 pmdata_soem with options rw,no_root_squash

Checking nfs share added - pmdata_sim on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 pmdata_sim with options rw,no_root_squash

Checking if NAS filesystem is shared on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully shared NAS filesystems

Checking if install stage - create_volume_group is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_volume_group

Checking if volume group stats_coordinator_pool is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 volume group stats_coordinator_pool created

Checking if install stage - create_logical_volume_filesystem is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_coordinator_pool-rep_main filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-rep_main filesystem

Checking if fileSystem stats_coordinator_pool-rep_main is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-rep_main

Checking if /etc/fstab file with filesystem stats_coordinator_pool-rep_main is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-rep_main

Checking if stats_coordinator_pool-rep_temp filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-rep_temp filesystem

Checking if fileSystem stats_coordinator_pool-rep_temp is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_coordinator_pool-rep_temp is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-rep_temp

Checking if stats_coordinator_pool-dwh_main filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-dwh_main filesystem

Checking if fileSystem stats_coordinator_pool-dwh_main is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_main is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_main

Checking if stats_coordinator_pool-dwh_reader filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-dwh_reader filesystem

Checking if fileSystem stats_coordinator_pool-dwh_reader is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_reader is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_reader

Checking if stats_coordinator_pool-dwh_main_dbspace filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_coordinator_pool-dwh_main_dbspace is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_main_dbspace is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_main_dbspace

Checking if stats_coordinator_pool-dwh_temp_dbspace filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_coordinator_pool-dwh_temp_dbspace is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_coordinator_pool-dwh_temp_dbspace is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-dwh_temp_dbspace

Checking if stats_coordinator_pool-misc is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-misc

Checking if fileSystem stats_coordinator_pool-misc is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-misc

Checking if /etc/fstab file with filesystem stats_coordinator_pool-misc is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-misc

Checking if stats_coordinator_pool-bkup_sw filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-bkup_sw filesystem

Checking if fileSystem stats_coordinator_pool-bkup_sw is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_coordinator_pool-bkup_sw is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-bkup_sw

Checking if stats_coordinator_pool-connectd filesystem is successfully removed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Removing the stats_coordinator_pool-connectd filesystem

Checking if fileSystem stats_coordinator_pool-connectd is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating fileSystem stats_coordinator_pool-connectd

Checking if /etc/fstab file with filesystem stats_coordinator_pool-connectd is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /etc/fstab file with filesystem stats_coordinator_pool-connectd

Checking if FS filesystems are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating group dc5000

Checking if groups are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created groups

Checking if stage - create_users is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking ssh keys for dcuser are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating ssh keys for dcuser

Checking if /eniq/home/dcuser/.ssh is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating /eniq/home/dcuser/.ssh

Checking if ownership of /eniq/home/dcuser/.ssh to dcuser is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/home/dcuser/.ssh to dcuser

Checking if ownership of /eniq/home/dcuser/.ssh/id_rsa to dcuser is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/home/dcuser/.ssh/id_rsa to dcuser

Checking if ownership of /eniq/home/dcuser/.ssh/id_rsa.pub to dcuser is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/home/dcuser/.ssh/id_rsa.pub to dcuser

Checking if /eniq/home/dcuser/.ssh/authorized_keys file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /eniq/home/dcuser/.ssh/authorized_keys file

Checking if users are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created users
    
Checking if stage - relocate_sentinel is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - relocate_sentinel
    
Checking if files from /var/tmp/sentinel to /eniq/sentinel are successfully copied on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Copying files from /var/tmp/sentinel to /eniq/sentinel
    
Checking if /eniq/sentinel is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Recreating /eniq/sentinel
    
Checking if migration to NAS is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully migrated to NAS
    
Checking if stage - create_directories is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_directories
    
Checking if required directories are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created required directories
    
Checking if filesystem stats_coordinator_pool-rep_main ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-rep_main ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-rep_main permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-rep_main permissions to 0755
    
Checking if filesystem stats_coordinator_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-rep_temp ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-rep_temp permissions to 1755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-rep_temp permissions to 1755
    
Checking if filesystem stats_coordinator_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-dwh_main ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-dwh_main permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-dwh_main permissions to 0755
    
Checking if filesystem stats_coordinator_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-dwh_reader ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-dwh_reader permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-dwh_reader permissions to 0755
    
Checking if filesystem stats_coordinator_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-dwh_main_dbspace ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-dwh_main_dbspace permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-dwh_main_dbspace permissions to 0755
    
Checking if filesystem stats_coordinator_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-dwh_temp_dbspace ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-dwh_temp_dbspace permissions to 1755
    
Checking if filesystem stats_coordinator_pool-misc ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-misc ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-misc permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-misc permissions to 0755
    
Checking if filesystem stats_coordinator_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-bkup_sw ownership to dcuser:dc5000
    
Checking if fileSystem stats_coordinator_pool-bkup_sw permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-bkup_sw permissions to 0755
    
Checking if filesystem stats_coordinator_pool-connectd ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing filesystem stats_coordinator_pool-connectd ownership to dcuser:dc5000
    
Checking if Changing fileSystem stats_coordinator_pool-connectd permissions to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing fileSystem stats_coordinator_pool-connectd permissions to 0755
    
Checking if directory /eniq/admin is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/admin
    
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
    
Checking if permissions on /eniq/admin to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/admin to 0755
    
Checking if directory /eniq/archive is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/archive
    
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
    
Checking if permissions on /eniq/archive to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/archive to 0755
    
Checking if directory /eniq/backup is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/backup
    
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on coordinator 
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
    
Checking if permissions on /eniq/backup to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/backup to 0755
    
Checking if directory /eniq/data is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data
    
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
    
Checking if permissions on /eniq/data to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data to 0755
    
Checking if directory /eniq/data/etldata is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/etldata
    
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/etldata to 0755
    
Checking if directory /eniq/data/etldata_ is created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/etldata_
    
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
    
Checking if directory /eniq/data/etldata_/00 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
    
Checking if directory /eniq/data/etldata_/01 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
    
Checking if directory /eniq/data/etldata_/02 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/etldata_/02
    
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
    
Checking if directory /eniq/data/etldata_/03 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/etldata_/03
    
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
    
Checking if directory /eniq/data/pmdata is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata
    
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata to 0755
    
Checking if directory /eniq/data/pmdata/eventdata is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata
    
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
    
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
    
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
    
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
    
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
    
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
    
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
    
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
    
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
    
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
    
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
    
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
    
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
    
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
    
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
    
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
    
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
    
Checking if directory /eniq/data/rejected is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/rejected
    
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
    
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/rejected to 0755
    
Checking if directory /eniq/database/dwh_main is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main
    
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
    
Checking if directory /eniq/glassfish is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/glassfish
    
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
    
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/glassfish to 0755
    
Checking if directory /eniq/home is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/home
    
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
    
Checking if permissions on /eniq/home to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/home to 0755
    
Checking if directory /eniq/log is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/log
    
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
    
Checking if permissions on /eniq/log to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/log to 0755
    
Checking if directory /eniq/mediation_sw is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/mediation_sw
    
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
    
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/mediation_sw to 0755
    
Checking if directory /eniq/mediation_inter is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/mediation_inter
    
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/mediation_inter to 0755
    
Checking if directory /eniq/sentinel is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sentinel
    
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
    
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sentinel to 0755
    
Checking if directory /eniq/smf is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/smf
    
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
    
Checking if permissions on /eniq/smf to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/smf to 0755
    
Checking if directory /eniq/snapshot is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/snapshot
    
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
    
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/snapshot to 0755
    
Checking if directory /eniq/sql_anywhere is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sql_anywhere
    
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
    
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
    
Checking if directory /eniq/sybase_iq is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sybase_iq
    
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
    
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sybase_iq to 0755
    
Checking if directory /eniq/sw is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw
    
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
    
Checking if permissions on /eniq/sw to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw to 0755
    
Checking if directory /eniq/sw/bin is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw/bin
    
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
    
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw/bin to 0755
    
Checking if directory /eniq/sw/conf is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw/conf
    
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
    
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw/conf to 0755
    
Checking if directory /eniq/sw/installer is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw/installer
    
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
    
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw/installer to 0755
    
Checking if directory /eniq/sw/log is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw/log
    
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
    
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw/log to 0755
    
Checking if directory /eniq/sw/platform is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw/platform
    
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
    
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw/platform to 0755
    
Checking if directory /eniq/sw/runtime is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/sw/runtime
    
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
    
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/sw/runtime to 0755
    
Checking if directory /eniq/upgrade is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/upgrade
    
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
    
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/upgrade to 0755
    
Checking if directory /eniq/database/rep_main is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/rep_main
    
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
    
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/rep_main to 0755
    
Checking if directory /eniq/database/rep_temp is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/rep_temp
    
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
    
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
    
Checking if directory /eniq/data/reference is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/reference
    
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
    
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/reference to 0755
    
Checking if directory /eniq/northbound is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/northbound
    
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
    
Checking if permissions on /eniq/northbound to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/northbound to 0755
    
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
    
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
    
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
    
Checking if directory /eniq/data/pushData is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData
    
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData to 0775
    
Checking if directory /eniq/data/pushData/00 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/00
    
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
    
Checking if directory /eniq/data/pushData/01 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/01
    
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
    
Checking if directory /eniq/data/pushData/02 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/02
    
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
    
Checking if directory /eniq/data/pushData/03 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/03
    
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
    
Checking if directory /eniq/data/pushData/04 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/04
    
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
    
Checking if directory /eniq/data/pushData/05 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/05
    
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
    
Checking if directory /eniq/data/pushData/06 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/06
    
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
    
Checking if directory /eniq/data/pushData/07 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/07
    
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
    
Checking if directory /eniq/data/pushData/08 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
    
Checking if directory /eniq/data/pushData/09 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/09
    
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
    
Checking if directory /eniq/data/pushData/10 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/10
    
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
    
Checking if directory /eniq/data/pushData/11 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/11
    
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
    
Checking if directory /eniq/data/pushData/12 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/12
    
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
    
Checking if directory /eniq/data/pushData/13 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/13
    
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
    
Checking if directory /eniq/data/pushData/14 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/14
    
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
    
Checking if directory /eniq/data/pushData/15 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pushData/15
    
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
    
Checking if directory /eniq/misc/ldap_db is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/misc/ldap_db
    
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
    
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
    
Checking if directory /eniq/export is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/export
    
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
    
Checking if permissions on /eniq/export to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/export to 0755
    
Checking if directory /eniq/fmdata is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/fmdata
    
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
    
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/fmdata to 0755
    
Checking if directory /eniq/database is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database
    
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
    
Checking if permissions on /eniq/database to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
    
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
    
Checking if irectory /eniq/database/dwh_reader is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_reader
    
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
    
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
    
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
    
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
    
Checking if directory /eniq/data/pmdata_soem is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Creating directory /eniq/data/pmdata_soem
    
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
    
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
    
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
    
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
    
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
    
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
    
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
    
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
    
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
    
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
    
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
    
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
    
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
    
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
    
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
    
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
    
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
    
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
    
Checking if stage - populate_nasd_config is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - populate_nasd_config
    
Checking if stage - populate_nasd_config is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed stage - populate_nasd_config
    
Checking if stage - change_mount_owners is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - change_mount_owners
    
Checking if directory permissions are successfully changed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully changed directory permissions
    
Checking if stage - install_host_syncd is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_host_syncd
    
Checking if hostsync monitor scripts are successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed hostsync monitor scripts
    
Checking if hostsync unit file is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed hostsync unit file
    
Checking if hostsync unit is successfully loaded on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully loaded hostsync unit
    
Checking if hostsyncd is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed hostsyncd
    
Checking if stage - install_connectd_sw is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_connectd_sw
    
Checking if SW to /eniq/connectd is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed SW to /eniq/connectd
    
Checking if stage - install_backup_sw is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_backup_sw
    
Checking if SW to /eniq/bkup_sw is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed SW to /eniq/bkup_sw
    
Checking if stage - create_admin_dir is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_admin_dir
    
Checking if /eniq/admin directory is successfully populated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully populated /eniq/admin directory
    
Checking if stage - generate_keys is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - generate_keys
    
Checking if stage - generate_keys is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - generate_keys
    
Checking if stage - create_rbac_roles is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_rbac_roles
    
Checking if configuration for ENIQ user roles is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed configuration for ENIQ user roles
    
Checking if stage - update_ENIQ_env_files is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering Core Install stage - update_ENIQ_env_files
    
Checking if OSS is successfully added on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Addition of OSS successful
    
Checking if the wtmp file is successfully nullified on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully nullified the wtmp file
    
Checking if ENIQ ENV file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully updated ENIQ ENV file
    
Checking if stage - install_sybaseiq is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_sybaseiq
    
Checking if SYBASE IQ is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed SYBASE IQ
    
Checking if stage - install_sybase_asa is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_sybase_asa
    
Checking if SYBASE ASA is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed SYBASE ASA
    
Checking if stage - update_sysuser_file is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - update_sysuser_file
    
Checking if stage - update_sysuser_file is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - update_sysuser_file
    
Checking if stage - create_db_sym_links is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_db_sym_links
    
Checking if DB Sym Links is successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created DB Sym Links
    
Checking if stage - create_repdb is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_repdb
    
Checking if stage - create_repdb is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed stage - create_repdb
    
Checking if stage - create_dwhdb is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - create_dwhdb
    
Checking if stage - create_dwhdb is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed stage - create_dwhdb
    
Checking if stage - install_ENIQ_platform is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_ENIQ_platform
    
Checking if ENIQ Platform is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed ENIQ Platform
    
Checking if Features are successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed Features
    
Checking if stage - activate_ENIQ_features is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - activate_ENIQ_features
    
Checking if feature interfaces are successfully activated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully activated feature interfaces
    
Checking if stage - setup_SMF_scripts is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - setup_SMF_scripts
    
Checking if Service scripts are successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully installed Service scripts
    
Checking if stage - install_extra_fs is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
    
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
    
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
    
Checking if stage - install_extra_fs is successfully completed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully completed core install stage - install_extra_fs
    
Checking if stage - install_rolling_snapshot is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - install_rolling_snapshot
    
Checking if rolling snapshots are successfully created on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully created rolling snapshots
    
Checking if crontab is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Crontab updated successfully
    
Checking if stage - validate_SMF_contracts is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - validate_SMF_contracts
    
Checking if SMF manifest files are successfully validated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully validated SMF manifest files
    
Checking if stage - add_alias_details_to_service_names is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - add_alias_details_to_service_names
    
Checking if NAS alias information in /etc/hosts is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully updated NAS alias information in /etc/hosts
    
Checking if stage - cleanup is successfully entered on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Entering core install stage - cleanup
    
Checking if ENIQ status file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 Successfully updated ENIQ status file
    
Checking if /eniq/admin/version/eniq_history file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 /eniq/admin/version/eniq_history file updated correctly
    
Checking if /eniq/admin/version/eniq_status file is successfully updated on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 /eniq/admin/version/eniq_status file updated correctly

Checking if ENIQ SW is successfully installed on coordinator
    [Tags]             II  MB-Coordinator
    Should Contain     ${II_CO_Log}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  MB-Coordinator 
    Should Contain     ${II_CO_Log}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]                      II  MB-Coordinator
    ${count}=	                Get Count      		   ${II_CO_Log}				tomcat_users_history.properties: No such file or directory
    Should Contain X Times      ${II_CO_Log}               No such file or directory		${count}

Checking if stage list is successfully built on engine
    [Tags]             II  MB-Engine
    ${II_ENG_Log}=     Get File                   II-MB-Engine.log
    Set Global Variable      ${II_ENG_Log}
    Should Contain     ${II_ENG_Log}              Building stage list from /eniq/installation/core_install/etc/stats_stats_engine_stagelist
    
Checking if stage - allow_root_access is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - get_storage_type

Checking if storage type is set successfully set on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - update_netmasks_file

Checking if stage - update_netmasks_file is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - update_netmasks_file

Checking if stage - configure_storage_api is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - build_ini_file

Checking if ssh connectivity for NAS is successfully setup on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Setting up ssh connectivity for NAS

Checking if ini files are successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed NASd

Checking if install stage - create_volume_group is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_volume_group

Checking if install stage - create_logical_volume_filesystem is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_engine_pool-rep_main filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-rep_main filesystem

Checking if fileSystem stats_engine_pool-rep_main is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-rep_main

Checking if /etc/fstab file with filesystem stats_engine_pool-rep_main is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-rep_main

Checking if stats_engine_pool-rep_temp filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-rep_temp filesystem

Checking if fileSystem stats_engine_pool-rep_temp is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_engine_pool-rep_temp is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-rep_temp

Checking if stats_engine_pool-dwh_main filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-dwh_main filesystem

Checking if fileSystem stats_engine_pool-dwh_main is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_main is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_main

Checking if stats_engine_pool-dwh_reader filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-dwh_reader filesystem

Checking if fileSystem stats_engine_pool-dwh_reader is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_reader is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_reader

Checking if stats_engine_pool-dwh_main_dbspace filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_engine_pool-dwh_main_dbspace is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_main_dbspace is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_main_dbspace

Checking if stats_engine_pool-dwh_temp_dbspace filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_engine_pool-dwh_temp_dbspace is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_engine_pool-dwh_temp_dbspace is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-dwh_temp_dbspace

Checking if stats_engine_pool-misc filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-misc filesystem

Checking if fileSystem stats_engine_pool-misc is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-misc

Checking if /etc/fstab file with filesystem stats_engine_pool-misc is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-misc

Checking if stats_engine_pool-bkup_sw filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-bkup_sw filesystem

Checking if fileSystem stats_engine_pool-bkup_sw is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_engine_pool-bkup_sw is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-bkup_sw

Checking if stats_engine_pool-connectd filesystem is successfully removed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Removing the stats_engine_pool-connectd filesystem

Checking if fileSystem stats_engine_pool-connectd is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating fileSystem stats_engine_pool-connectd

Checking if /etc/fstab file with filesystem stats_engine_pool-connectd is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /etc/fstab file with filesystem stats_engine_pool-connectd

Checking if FS filesystems are successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating group dc5000

Checking if groups are successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created groups

Checking if stage - create_users is entered successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking if users are successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created users
    
Checking if stage - create_directories is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_directories
    
Checking if required directories are successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created required directories
    
Checking if filesystem stats_engine_pool-rep_main ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-rep_main ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-rep_main permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-rep_main permissions to 0755
    
Checking if filesystem stats_engine_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-rep_temp ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-rep_temp permissions to 1755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-rep_temp permissions to 1755
    
Checking if filesystem stats_engine_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-dwh_main ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-dwh_main permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-dwh_main permissions to 0755
    
Checking if filesystem stats_engine_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-dwh_reader ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-dwh_reader permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-dwh_reader permissions to 0755
    
Checking if filesystem stats_engine_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-dwh_main_dbspace ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-dwh_main_dbspace permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-dwh_main_dbspace permissions to 0755
    
Checking if filesystem stats_engine_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-dwh_temp_dbspace ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-dwh_temp_dbspace permissions to 1755
    
Checking if filesystem stats_engine_pool-misc ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-misc ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-misc permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-misc permissions to 0755
    
Checking if filesystem stats_engine_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-bkup_sw ownership to dcuser:dc5000
    
Checking if fileSystem stats_engine_pool-bkup_sw permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-bkup_sw permissions to 0755
    
Checking if filesystem stats_engine_pool-connectd ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing filesystem stats_engine_pool-connectd ownership to dcuser:dc5000
    
Checking if Changing fileSystem stats_engine_pool-connectd permissions to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing fileSystem stats_engine_pool-connectd permissions to 0755
    
Checking if directory /eniq/admin is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/admin
    
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
    
Checking if permissions on /eniq/admin to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/admin to 0755
    
Checking if directory /eniq/archive is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/archive
    
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
    
Checking if permissions on /eniq/archive to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/archive to 0755
    
Checking if directory /eniq/backup is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/backup
    
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
    
Checking if permissions on /eniq/backup to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/backup to 0755
    
Checking if directory /eniq/data is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data
    
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
    
Checking if permissions on /eniq/data to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data to 0755
    
Checking if directory /eniq/data/etldata is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/etldata
    
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/etldata to 0755
    
Checking if directory /eniq/data/etldata_ is created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/etldata_
    
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
    
Checking if directory /eniq/data/etldata_/00 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
    
Checking if directory /eniq/data/etldata_/01 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
    
Checking if directory /eniq/data/etldata_/02 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/etldata_/02
    
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
    
Checking if directory /eniq/data/etldata_/03 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/etldata_/03
    
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
    
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
    
Checking if directory /eniq/data/pmdata is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata
    
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata to 0755
    
Checking if directory /eniq/data/pmdata/eventdata is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata
    
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
    
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
    
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
    
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
    
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
    
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
    
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
    
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
    
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
    
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
    
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
    
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
    
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
    
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
    
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
    
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
    
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
    
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
    
Checking if directory /eniq/data/rejected is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/rejected
    
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
    
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/rejected to 0755
    
Checking if directory /eniq/database/dwh_main is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main
    
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
    
Checking if directory /eniq/glassfish is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/glassfish
    
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
    
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/glassfish to 0755
    
Checking if directory /eniq/home is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/home
    
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
    
Checking if permissions on /eniq/home to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/home to 0755
    
Checking if directory /eniq/log is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/log
    
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
    
Checking if permissions on /eniq/log to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/log to 0755
    
Checking if directory /eniq/mediation_sw is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/mediation_sw
    
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
    
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/mediation_sw to 0755
    
Checking if directory /eniq/mediation_inter is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/mediation_inter
    
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/mediation_inter to 0755
    
Checking if directory /eniq/sentinel is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sentinel
    
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
    
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sentinel to 0755
    
Checking if directory /eniq/smf is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/smf
    
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
    
Checking if permissions on /eniq/smf to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/smf to 0755
    
Checking if directory /eniq/snapshot is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/snapshot
    
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
    
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/snapshot to 0755
    
Checking if directory /eniq/sql_anywhere is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sql_anywhere
    
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
    
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
    
Checking if directory /eniq/sybase_iq is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sybase_iq
    
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
    
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sybase_iq to 0755
    
Checking if directory /eniq/sw is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw
    
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
    
Checking if permissions on /eniq/sw to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw to 0755
    
Checking if directory /eniq/sw/bin is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw/bin
    
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
    
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw/bin to 0755
    
Checking if directory /eniq/sw/conf is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw/conf
    
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
    
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw/conf to 0755
    
Checking if directory /eniq/sw/installer is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw/installer
    
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
    
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw/installer to 0755
    
Checking if directory /eniq/sw/log is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw/log
    
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
    
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw/log to 0755
    
Checking if directory /eniq/sw/platform is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw/platform
    
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
    
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw/platform to 0755
    
Checking if directory /eniq/sw/runtime is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/sw/runtime
    
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
    
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/sw/runtime to 0755
    
Checking if directory /eniq/upgrade is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/upgrade
    
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
    
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/upgrade to 0755
    
Checking if directory /eniq/database/rep_main is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/rep_main
    
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
    
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/rep_main to 0755
    
Checking if directory /eniq/database/rep_temp is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/rep_temp
    
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
    
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
    
Checking if directory /eniq/data/reference is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/reference
    
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
    
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/reference to 0755
    
Checking if directory /eniq/northbound is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/northbound
    
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
    
Checking if permissions on /eniq/northbound to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/northbound to 0755
    
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
    
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
    
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
    
Checking if directory /eniq/data/pushData is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData
    
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData to 0775
    
Checking if directory /eniq/data/pushData/00 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/00
    
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
    
Checking if directory /eniq/data/pushData/01 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/01
    
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
    
Checking if directory /eniq/data/pushData/02 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/02
    
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
    
Checking if directory /eniq/data/pushData/03 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/03
    
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
    
Checking if directory /eniq/data/pushData/04 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/04
    
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
    
Checking if directory /eniq/data/pushData/05 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/05
    
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
    
Checking if directory /eniq/data/pushData/06 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/06
    
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
    
Checking if directory /eniq/data/pushData/07 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/07
    
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
    
Checking if directory /eniq/data/pushData/08 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
    
Checking if directory /eniq/data/pushData/09 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/09
    
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
    
Checking if directory /eniq/data/pushData/10 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/10
    
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
    
Checking if directory /eniq/data/pushData/11 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/11
    
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
    
Checking if directory /eniq/data/pushData/12 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/12
    
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
    
Checking if directory /eniq/data/pushData/13 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/13
    
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
    
Checking if directory /eniq/data/pushData/14 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/14
    
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
    
Checking if directory /eniq/data/pushData/15 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pushData/15
    
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
    
Checking if directory /eniq/misc/ldap_db is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/misc/ldap_db
    
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
    
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
    
Checking if directory /eniq/export is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/export
    
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
    
Checking if permissions on /eniq/export to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/export to 0755
    
Checking if directory /eniq/fmdata is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/fmdata
    
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
    
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/fmdata to 0755
    
Checking if directory /eniq/database is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database
    
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on engine on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
    
Checking if permissions on /eniq/database to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
    
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
    
Checking if irectory /eniq/database/dwh_reader is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_reader
    
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
    
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
    
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
    
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
    
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
    
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
    
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
    
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
    
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
    
Checking if directory /eniq/data/pmdata_soem is successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Creating directory /eniq/data/pmdata_soem
    
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
    
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
    
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
    
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
    
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
    
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
    
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
    
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
    
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
    
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
    
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
    
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
    
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
    
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
    
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
    
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
    
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
    
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
    
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
    
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
    
Checking if stage - populate_nasd_config is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - populate_nasd_config
    
Checking if stage - populate_nasd_config is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed stage - populate_nasd_config
    
Checking if stage - change_mount_owners is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - change_mount_owners
    
Checking if directory permissions are successfully changed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully changed directory permissions
    
Checking if stage - install_host_syncd is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_host_syncd
    
Checking if hostsync monitor scripts are successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed hostsync monitor scripts
    
Checking if hostsync unit file is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed hostsync unit file
    
Checking if hostsync unit is successfully loaded on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully loaded hostsync unit
    
Checking if hostsyncd is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed hostsyncd
    
Checking if stage - install_connectd_sw is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_connectd_sw
    
Checking if SW to /eniq/connectd is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed SW to /eniq/connectd
    
Checking if stage - install_backup_sw is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_backup_sw
    
Checking if SW to /eniq/bkup_sw is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed SW to /eniq/bkup_sw
    
Checking if stage - create_admin_dir is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_admin_dir
    
Checking if /eniq/admin directory is successfully populated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully populated /eniq/admin directory
    
Checking if stage - generate_keys is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - generate_keys
    
Checking if stage - generate_keys is successfully skipped on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Non-coordinator install - skipping core install stage - generate_keys
    
Checking if stage - create_rbac_roles is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - create_rbac_roles
    
Checking if configuration for ENIQ user roles is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed configuration for ENIQ user roles
    
Checking if stage - update_ENIQ_env_files is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering Core Install stage - update_ENIQ_env_files
    
Checking if the wtmp file is successfully nullified on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully nullified the wtmp file
    
Checking if ENIQ ENV file is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully updated ENIQ ENV file
    
Checking if stage - update_sysuser_file is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - update_sysuser_file
    
Checking if stage - update_sysuser_file is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - update_sysuser_file
    
Checking if stage - setup_SMF_scripts is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - setup_SMF_scripts
    
Checking if Service scripts are successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully installed Service scripts
    
Checking if stage - install_extra_fs is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
    
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
    
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
    
Checking if stage - install_extra_fs is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed core install stage - install_extra_fs
    
Checking if stage - install_rolling_snapshot is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - install_rolling_snapshot
    
Checking if rolling snapshots are successfully created on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully created rolling snapshots
    
Checking if crontab is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Crontab updated successfully
    
Checking if stage - validate_SMF_contracts is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - validate_SMF_contracts
    
Checking if SMF manifest files are successfully validated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully validated SMF manifest files
    
Checking if stage - add_alias_details_to_service_names is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - add_alias_details_to_service_names
    
Checking if NAS alias information in /etc/hosts is successfully updated on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully updated NAS alias information in /etc/hosts
    
Checking if stage - cleanup is successfully entered on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Entering core install stage - cleanup
    
Checking if ENIQ cleanup stage is successfully completed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Successfully completed ENIQ cleanup stage
    
Checking if ENIQ SW is successfully installed on engine
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 ENIQ SW successfully installed
	
Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  MB-Engine
    Should Contain     ${II_ENG_Log}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]             II  MB-Engine
    Should Not Contain    ${II_ENG_Log}                 No such file or directory

Checking if stage list is successfully built on Reader1
    [Tags]             II  Reader1
    ${II_RD1_Log}=     Get File                   II-MB-Reader1.log
    Set Global Variable      ${II_RD1_Log}
    Should Contain     ${II_RD1_Log}              Building stage list from /eniq/installation/core_install/etc/stats_stats_iqr_stagelist

Checking if stage - allow_root_access is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - get_storage_type

Checking if storage type is set successfully set on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - update_netmasks_file

Checking if stage - update_netmasks_file is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - update_netmasks_file

Checking if stage - configure_storage_api is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - build_ini_file

Checking if ssh connectivity for NAS is successfully setup on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Setting up ssh connectivity for NAS

Checking if ini files are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed NASd

Checking if install stage - create_volume_group is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_volume_group

Checking if volume group stats_iqr_pool is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 volume group stats_iqr_pool created

Checking if install stage - create_logical_volume_filesystem is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_iqr_pool-rep_main filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-rep_main filesystem

Checking if fileSystem stats_iqr_pool-rep_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-rep_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_main is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_main

Checking if stats_iqr_pool-rep_temp filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-rep_temp filesystem

Checking if fileSystem stats_iqr_pool-rep_temp is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_temp is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_temp

Checking if stats_iqr_pool-dwh_main filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-dwh_main filesystem

Checking if fileSystem stats_iqr_pool-dwh_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main

Checking if stats_iqr_pool-dwh_reader filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-dwh_reader filesystem

Checking if fileSystem stats_iqr_pool-dwh_reader is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_reader is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_reader

Checking if stats_iqr_pool-dwh_main_dbspace filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_main_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace

Checking if stats_iqr_pool-dwh_temp_dbspace filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace

Checking if stats_iqr_pool-misc filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-misc filesystem

Checking if fileSystem stats_iqr_pool-misc is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-misc

Checking if /etc/fstab file with filesystem stats_iqr_pool-misc is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-misc

Checking if stats_iqr_pool-bkup_sw filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-bkup_sw filesystem

Checking if fileSystem stats_iqr_pool-bkup_sw is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_iqr_pool-bkup_sw is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-bkup_sw

Checking if stats_iqr_pool-connectd filesystem is successfully removed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Removing the stats_iqr_pool-connectd filesystem

Checking if fileSystem stats_iqr_pool-connectd is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating fileSystem stats_iqr_pool-connectd

Checking if /etc/fstab file with filesystem stats_iqr_pool-connectd is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-connectd

Checking if FS filesystems are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating group dc5000

Checking if groups are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created groups

Checking if stage - create_users is entered successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking if users are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created users
	
Checking if stage - create_directories is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_directories
	
Checking if required directories are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created required directories
	
Checking if filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_main permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-rep_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_temp permissions to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_reader permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_iqr_pool-misc ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-misc permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-misc permissions to 0755
	
Checking if filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-bkup_sw permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_iqr_pool-connectd permissions to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing fileSystem stats_iqr_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on Reader1 
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if irectory /eniq/database/dwh_reader is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if stage - populate_nasd_config is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - populate_nasd_config
	
Checking if stage - populate_nasd_config is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed stage - populate_nasd_config
	
Checking if stage - change_mount_owners is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - change_mount_owners
	
Checking if directory permissions are successfully changed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully changed directory permissions
	
Checking if stage - install_host_syncd is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed hostsync unit file
	
Checking if hostsync unit is successfully loaded on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed hostsyncd
	
Checking if stage - install_connectd_sw is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_connectd_sw
	
Checking if SW to /eniq/connectd is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed SW to /eniq/connectd
	
Checking if stage - install_backup_sw is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_backup_sw
	
Checking if SW to /eniq/bkup_sw is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if stage - create_admin_dir is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - generate_keys
	
Checking if stage - generate_keys is successfully skipped on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Non-coordinator install - skipping core install stage - generate_keys
	
Checking if stage - create_rbac_roles is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if the wtmp file is successfully nullified on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully updated ENIQ ENV file

Checking if stage - update_sysuser_file is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - update_sysuser_file
	
Checking if stage - update_sysuser_file is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - update_sysuser_file
	
Checking if stage - create_db_sym_links is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - create_db_sym_links
	
Checking if DB Sym Links is successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created DB Sym Links
	
Checking if stage - setup_SMF_scripts is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully installed Service scripts
	
Checking if stage - install_extra_fs is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
	
Checking if stage - install_extra_fs is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - install_rolling_snapshot is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - install_rolling_snapshot
	
Checking if rolling snapshots are successfully created on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully created rolling snapshots
	
Checking if crontab is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Crontab updated successfully
	
Checking if stage - validate_SMF_contracts is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files are successfully validated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully validated SMF manifest files
	
Checking if stage - add_alias_details_to_service_names is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - add_alias_details_to_service_names
	
Checking if NAS alias information in /etc/hosts is successfully updated on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully updated NAS alias information in /etc/hosts
	
Checking if stage - cleanup is successfully entered on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Entering core install stage - cleanup
	
Checking if ENIQ cleanup stage is successfully completed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 Successfully completed ENIQ cleanup stage

Checking if ENIQ SW is successfully installed on Reader1
    [Tags]             II  Reader1
    Should Contain     ${II_RD1_Log}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II   Reader1
    Should Contain     ${II_RD1_Log}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]             II   Reader1
    Should Not Contain    ${II_RD1_Log}                 No such file or directory

Checking if stage list is successfully built on Reader2
    [Tags]             II  Reader2
    ${II_RD2_Log}=     Get File                   II-MB-Reader2.log
    Set Global Variable      ${II_RD2_Log}
    Should Contain     ${II_RD2_Log}              Building stage list from /eniq/installation/core_install/etc/stats_stats_iqr_stagelist

Checking if stage - allow_root_access is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - allow_root_access

Checking if stage - allow_root_access is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - allow_root_access

Checking if stage - get_storage_type is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - get_storage_type

Checking if storage type is set successfully set on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully set storage type

Checking if stage - install_sentinel is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_sentinel

Checking if ENIQ SentinelLM installation script is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed ENIQ SentinelLM installation script

Checking if ENIQ Sentinel server is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed ENIQ Sentinel server

Checking if stage - install_san_sw is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_san_sw

Checking if SAN SW is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed SAN SW

Checking if stage - install_storage_api is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_storage_api

Checking if Storage API SW is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed Storage API SW

Checking if stage - get_update_server_netmask is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - get_update_server_netmask

Checking if stage - get_update_server_netmask is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - get_update_server_netmask

Checking if stage - get_ipmp_info is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - get_ipmp_info

Checking if bond information is successfully gathered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully gathered bond information

Checking if stage - setup_ipmp is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - setup_ipmp

Checking if bond is successfully setup on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully setup bond

Checking if stage - update_netmasks_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - update_netmasks_file

Checking if stage - update_netmasks_file is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - update_netmasks_file

Checking if stage - configure_storage_api is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - configure_storage_api

Checking if storage API is successfully configured on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully configured storage API

Checking if stage - build_ini_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - build_ini_file

Checking if ssh connectivity for NAS is successfully setup on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Setting up ssh connectivity for NAS

Checking if ini files are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created ini files

Checking if stage - install_service_scripts is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_service_scripts

Checking if stage - update_system_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - update_system_file

Checking if stage - update_system_file is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - update_system_file

Checking if stage - update_defaultrouter_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - update_defaultrouter_file

Checking if /etc/sysconfig/network file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully updated /etc/sysconfig/network file

Checking if stage - update_dns_files is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - update_dns_files

Checking if system DNS file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully updated system DNS file

Checking if stage - update_timezone_info is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - update_timezone_info

Checking if stage - update_timezone_info is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - update_timezone_info

Checking if stage - install_nasd is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_nasd

Checking if NASd is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed NASd

Checking if install stage - create_volume_group is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_volume_group

Checking if volume group stats_iqr_pool is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 volume group stats_iqr_pool created

Checking if install stage - create_logical_volume_filesystem is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_logical_volume_filesystem

Checking if volume group is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created volume group

Checking if volume group from /eniq/installation/config/SunOS.ini is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating volume group from /eniq/installation/config/SunOS.ini

Checking if stats_iqr_pool-rep_main filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-rep_main filesystem

Checking if fileSystem stats_iqr_pool-rep_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-rep_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_main is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_main

Checking if stats_iqr_pool-rep_temp filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-rep_temp filesystem

Checking if fileSystem stats_iqr_pool-rep_temp is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-rep_temp

Checking if /etc/fstab file with filesystem stats_iqr_pool-rep_temp is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-rep_temp

Checking if stats_iqr_pool-dwh_main filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-dwh_main filesystem

Checking if fileSystem stats_iqr_pool-dwh_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-dwh_main

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main

Checking if stats_iqr_pool-dwh_reader filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-dwh_reader filesystem

Checking if fileSystem stats_iqr_pool-dwh_reader is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-dwh_reader

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_reader is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_reader

Checking if stats_iqr_pool-dwh_main_dbspace filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-dwh_main_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_main_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-dwh_main_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_main_dbspace

Checking if stats_iqr_pool-dwh_temp_dbspace filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-dwh_temp_dbspace filesystem

Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-dwh_temp_dbspace

Checking if /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-dwh_temp_dbspace

Checking if stats_iqr_pool-misc filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-misc filesystem

Checking if fileSystem stats_iqr_pool-misc is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-misc

Checking if /etc/fstab file with filesystem stats_iqr_pool-misc is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-misc

Checking if stats_iqr_pool-bkup_sw filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-bkup_sw filesystem

Checking if fileSystem stats_iqr_pool-bkup_sw is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-bkup_sw

Checking if /etc/fstab file with filesystem stats_iqr_pool-bkup_sw is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-bkup_sw

Checking if stats_iqr_pool-connectd filesystem is successfully removed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Removing the stats_iqr_pool-connectd filesystem

Checking if fileSystem stats_iqr_pool-connectd is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating fileSystem stats_iqr_pool-connectd

Checking if /etc/fstab file with filesystem stats_iqr_pool-connectd is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /etc/fstab file with filesystem stats_iqr_pool-connectd

Checking if FS filesystems are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created FS filesystems

Checking if stage - create_groups is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_groups

Checking if group dc5000 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating group dc5000

Checking if groups are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created groups

Checking if stage - create_users is entered successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_users

Checking if /eniq/home directory is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating /eniq/home directory

Checking if permissions of /eniq/home/dcuser is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing /eniq/home/dcuser permissions to -rwxr-x---

Checking if users are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created users
	
Checking if stage - create_directories is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_directories
	
Checking if required directories are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created required directories
	
Checking if filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_main permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-rep_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_temp permissions to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_reader permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_iqr_pool-misc ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-misc permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-misc permissions to 0755
	
Checking if filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-bkup_sw permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_iqr_pool-connectd permissions to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing fileSystem stats_iqr_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on Reader2 
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if irectory /eniq/database/dwh_reader is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if stage - populate_nasd_config is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - populate_nasd_config
	
Checking if stage - populate_nasd_config is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed stage - populate_nasd_config
	
Checking if stage - change_mount_owners is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - change_mount_owners
	
Checking if directory permissions are successfully changed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully changed directory permissions
	
Checking if stage - install_host_syncd is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed hostsync unit file
	
Checking if hostsync unit is successfully loaded on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed hostsyncd
	
Checking if stage - install_connectd_sw is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_connectd_sw
	
Checking if SW to /eniq/connectd is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed SW to /eniq/connectd
	
Checking if stage - install_backup_sw is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_backup_sw
	
Checking if SW to /eniq/bkup_sw is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed SW to /eniq/bkup_sw
	
Checking if stage - create_admin_dir is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - generate_keys
	
Checking if stage - generate_keys is successfully skipped on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Non-coordinator install - skipping core install stage - generate_keys
	
Checking if stage - create_rbac_roles is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if the wtmp file is successfully nullified on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully updated ENIQ ENV file

Checking if stage - update_sysuser_file is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - update_sysuser_file
	
Checking if stage - update_sysuser_file is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - update_sysuser_file
	
Checking if stage - create_db_sym_links is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - create_db_sym_links
	
Checking if DB Sym Links is successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created DB Sym Links
	
Checking if stage - setup_SMF_scripts is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully installed Service scripts
	
Checking if stage - install_extra_fs is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_extra_fs

Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10 is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_10
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11 is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_11
	
Checking if /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12 is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Updating /eniq/installation/config/SunOS.ini with SunOS_ZFS_FS_12
	
Checking if stage - install_extra_fs is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - install_rolling_snapshot is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - install_rolling_snapshot
	
Checking if rolling snapshots are successfully created on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully created rolling snapshots
	
Checking if crontab is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Crontab updated successfully
	
Checking if stage - validate_SMF_contracts is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files are successfully validated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully validated SMF manifest files
	
Checking if stage - add_alias_details_to_service_names is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - add_alias_details_to_service_names
	
Checking if NAS alias information in /etc/hosts is successfully updated on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully updated NAS alias information in /etc/hosts
	
Checking if stage - cleanup is successfully entered on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Entering core install stage - cleanup
	
Checking if ENIQ cleanup stage is successfully completed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Successfully completed ENIQ cleanup stage

Checking if ENIQ SW is successfully installed on Reader2
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 ENIQ SW successfully installed

Checking if SAN storage device prompt is displayed successfully
    [Tags]             II  Reader2
    Should Contain     ${II_RD2_Log}                 Enter type of SAN storage device connected to this ENIQ deployment (e.g. unity, unityXT)

Checking file not found error in logs
    [Tags]             II   Reader2
    Should Not Contain    ${II_RD2_Log}                 No such file or directory
