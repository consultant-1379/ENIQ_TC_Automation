*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if unpacking core sw has successfully started
    [Tags]                        Upgrade  MB
    ${UG_MB_Log}=                 Get File                   Upgrade-MB.log
	Set Global Variable           ${UG_MB_Log}
    Should Contain                ${UG_MB_Log}               Unpacking core sw started
	
Checking if unpacking core sw has successfully finished on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully finished unpacking core SW
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck has successfully started
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 PRECHECK -- ALL SERVERS
	
Checking if precheck - CHECK_STORAGE_IP is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for CHECK_STORAGE_IP
	Should Be Equal As Strings    ${count}                   4

Checking if precheck - CHECK_STORAGE_IP is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for CHECK_STORAGE_IP
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - NAS_ONLINE is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for NAS_ONLINE
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - NAS_ONLINE is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for NAS_ONLINE
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - CORE_DUMP_CHECK is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for CORE_DUMP_CHECK
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - CORE_DUMP_CHECK is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for CORE_DUMP_CHECK
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - ENGINE_PROFILE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for ENGINE_PROFILE
	
Checking if precheck - ENGINE_PROFILE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for ENGINE_PROFILE
	
Checking if precheck - CHECK_LOCKFILE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for CHECK_LOCKFILE
	
Checking if precheck - CHECK_LOCKFILE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for CHECK_LOCKFILE
	
Checking if precheck - ENIQ_SERVICES is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for ENIQ_SERVICES
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - ENIQ_SERVICES is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for ENIQ_SERVICES
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - FILESYSTEM is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for FILESYSTEM
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - FILESYSTEM is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for FILESYSTEM
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - STARTER_LICENSE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for STARTER_LICENSE
	
Checking if precheck - STARTER_LICENSE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for STARTER_LICENSE
	
Checking if precheck - SSH_CHECK is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for SSH_CHECK
	
Checking if precheck - SSH_CHECK is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for SSH_CHECK
	
Checking if precheck - OSS_MOUNT is successfully started on coordinator and engine
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for OSS_MOUNT
	Should Be Equal As Strings    ${count}                   2
	
Checking if precheck - OSS_MOUNT is successfully completed on coordinator and engine
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for OSS_MOUNT
	Should Be Equal As Strings    ${count}                   2
	
Checking if precheck - INODES is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for INODES
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - INODES is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for INODES
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - FEATURE_LICENSE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for FEATURE_LICENSE
	
Checking if precheck - FEATURE_LICENSE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for FEATURE_LICENSE
	
Checking if precheck - SNAPSHOT_CACHE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for SNAPSHOT_CACHE
	
Checking if precheck - SNAPSHOT_CACHE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for SNAPSHOT_CACHE 

Checking if precheck - DROP_LEAK is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for DROP_LEAK
	
Checking if precheck - DROP_LEAK is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for DROP_LEAK
	
Checking if precheck - DB_IQ_USAGE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for DB_IQ_USAGE
	
Checking if precheck - DB_IQ_USAGE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for DB_IQ_USAGE
	
Checking if precheck - DB_MULTIPLEX_MODE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for DB_MULTIPLEX_MODE
	
Checking if precheck - DB_MULTIPLEX_MODE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for DB_MULTIPLEX_MODE
	
Checking if precheck - DB_HUNG_CONNECTION is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for DB_HUNG_CONNECTION
	
Checking if precheck - DB_HUNG_CONNECTION is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for DB_HUNG_CONNECTION
	
Checking if precheck - CRASH_DUMP is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for CRASH_DUMP
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - CRASH_DUMP is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for CRASH_DUMP
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - VG_STATUS is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for VG_STATUS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - VG_STATUS is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for VG_STATUS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - DIRECTORY_PERMS is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for DIRECTORY_PERMS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - DIRECTORY_PERMS is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for DIRECTORY_PERMS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - ENGINE_LOGS is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for ENGINE_LOGS
	
Checking if precheck - ENGINE_LOGS is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for ENGINE_LOGS
	
Checking if precheck - MESSAGES_LOGS is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for MESSAGES_LOGS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - MESSAGES_LOGS is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for MESSAGES_LOGS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - CHECK_PORT is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for CHECK_PORT
	
Checking if precheck - CHECK_PORT is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for CHECK_PORT
	
Checking if precheck - CAPACITY_LICENSE is successfully started on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck started for CAPACITY_LICENSE
	
Checking if precheck - CAPACITY_LICENSE is successfully completed on coordinator
    [Tags]                        Upgrade  MB
	Should Contain                ${UG_MB_Log}                 Precheck completed for CAPACITY_LICENSE
	
Checking if precheck - SNAPSHOT_CACHE_FS is successfully started on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck started for SNAPSHOT_CACHE_FS
	Should Be Equal As Strings    ${count}                   4
	
Checking if precheck - SNAPSHOT_CACHE_FS is successfully completed on all blades
    [Tags]                        Upgrade  MB
	${count}=                     Get Count                  ${UG_MB_Log}              Precheck completed for SNAPSHOT_CACHE_FS
	Should Be Equal As Strings    ${count}                   4
	
Checking if stage - create_snapshots is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering Upgrade stage - create_snapshots
	
Checking if Stage - update_dwh_reader is successfully skipped
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 INFO: Skipping Upgrade Stage - update_dwh_reader for Blade
	
Checking if stage - disable_oss_mounts is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering upgrade stage - disable_oss_mounts
	
Checking if Stage - disabled OSS Mounts is successfully completed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Completed Stage - disabled OSS Mounts on all required Servers
	
Checking if stage - core_sw_upgrade is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering Upgrade stage - core_sw_upgrade
	
Checking if upgrade is required
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Checking if upgrade is required
	
Checking if rollback check file is successfully created
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating rollback check file
	
Checking if required files and scripts
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Checking for required files and scripts
	
Checking if stage - install_nas_sw is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - install_nas_sw
	
Checking if new package ERICstmnas is successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully Installed new package ERICstmnas
	
Checking if NAS API is successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully installed NAS API
	
Checking if ERICstorapi package update has successfully started
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Starting to update ERICstorapi package
	
Checking if ERICstorapi package is successfully updated
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully updated ERICstorapi package
	
Checking if stage - install_host_syncd is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - install_host_syncd
	
Checking if hostsync monitor scripts are successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully installed hostsync monitor scripts
	
Checking if hostsync unit file has successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully installed hostsync unit file
	
Checking if hostsync unit has successfully loaded
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully loaded hostsync unit
	
Checking if hostsyncd is successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully installed hostsyncd
	
Checking if stage - install_sentinel is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - install_sentinel
	
Checking if stage - create_rbac_roles is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - create_rbac_roles
	
Checking if configuration for ENIQ user roles is successfully completed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully completed configuration for ENIQ user roles
	
Checking if stage - update_ENIQ_env_files is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering Core Install stage - update_ENIQ_env_files
	
Checking if the wtmp file is successfully nullified
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully nullified the wtmp file
	
Checking if ENIQ ENV file is successfully updated
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully updated ENIQ ENV file
	
Checking if stage - create_admin_dir is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - create_admin_dir
	
Checking if /eniq/admin directory is successfully populated
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully populated /eniq/admin directory
	
Checking if stage - generate_keys is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - generate_keys

Checking if stage - generate_keys is successfully completed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully completed core install stage - generate_keys
	
Checking if stage - install_service_scripts is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - install_service_scripts
	
Checking if SW to /eniq/smf is successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully installed SW to /eniq/smf
	
Checking if stage - setup_SMF_scripts is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - setup_SMF_scripts
	
Checking if Service scripts are successfully installed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully installed Service scripts
	
Checking if stage - validate_SMF_contracts is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - validate_SMF_contracts
	
Checking if SMF manifest files is successfully validated
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully validated SMF manifest files
	
Checking if stage - install_extra_fs is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - install_extra_fs
	
Checking if stage - install_extra_fs is successfully completed
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully completed core install stage - install_extra_fs
	
Checking if stage - create_directories is successfully entered
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Entering core install stage - create_directories
	
Checking if filesystem stats_coordinator_pool-rep_main ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-rep_main permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-rep_main permissions to 0755
	
Checking if filesystem stats_coordinator_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-rep_temp permissions to 1755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_coordinator_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_main permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_coordinator_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_reader permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_coordinator_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_main_dbspace permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_coordinator_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_coordinator_pool-misc ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-misc permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-misc permissions to 0755
	
Checking if filesystem stats_coordinator_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_coordinator_pool-bkup_sw permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_coordinator_pool-connectd ownership to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_coordinator_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_coordinator_pool-connectd permissions to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_coordinator_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on coordinator 
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if directory /eniq/database/dwh_reader is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on coordinator
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000

Checking if filesystem stats_engine_pool-rep_main ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-rep_main permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-rep_main permissions to 0755
	
Checking if filesystem stats_engine_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-rep_temp permissions to 1755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_engine_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_main permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_engine_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_reader permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_engine_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_main_dbspace permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_engine_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_engine_pool-misc ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-misc permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-misc permissions to 0755
	
Checking if filesystem stats_engine_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_engine_pool-bkup_sw permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_engine_pool-connectd ownership to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_engine_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_engine_pool-connectd permissions to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_engine_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on engine on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if directory /eniq/database/dwh_reader is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on engine
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if required directories are successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Successfully created required directories
	
Checking if filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_main permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-rep_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_temp permissions to 1755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_reader permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_iqr_pool-misc ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-misc permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-misc permissions to 0755
	
Checking if filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-bkup_sw permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_iqr_pool-connectd permissions to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on Reader1 
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if directory /eniq/database/dwh_reader is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on Reader1
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-rep_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_main permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-rep_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-rep_temp ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-rep_temp permissions to 1755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-rep_temp permissions to 1755
	
Checking if filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_main ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_main permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_reader ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_reader permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_reader permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_main_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_main_dbspace permissions to 0755
	
Checking if filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-dwh_temp_dbspace ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-dwh_temp_dbspace permissions to 1755
	
Checking if filesystem stats_iqr_pool-misc ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-misc ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-misc permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-misc permissions to 0755
	
Checking if filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-bkup_sw ownership to dcuser:dc5000
	
Checking if fileSystem stats_iqr_pool-bkup_sw permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-bkup_sw permissions to 0755
	
Checking if filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing filesystem stats_iqr_pool-connectd ownership to dcuser:dc5000
	
Checking if Changing fileSystem stats_iqr_pool-connectd permissions to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing fileSystem stats_iqr_pool-connectd permissions to 0755
	
Checking if directory /eniq/admin is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/admin
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if permissions on /eniq/admin to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/admin to 0755
	
Checking if directory /eniq/archive is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/archive
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if permissions on /eniq/archive to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/archive to 0755
	
Checking if directory /eniq/backup is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/backup
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if permissions on /eniq/backup to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/backup to 0755
	
Checking if directory /eniq/data is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data
	
Checking if ownership of /eniq/data to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data to dcuser:dc5000
	
Checking if permissions on /eniq/data to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data to 0755
	
Checking if directory /eniq/data/etldata is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata
	
Checking if ownership of /eniq/data/etldata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata to 0755
	
Checking if directory /eniq/data/etldata_ is created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_
	
Checking if ownership of /eniq/data/etldata_ to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_ to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_ to 0755 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_ to 0755
	
Checking if directory /eniq/data/etldata_/00 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/00

Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/00 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/00 to 0755
	
Checking if directory /eniq/data/etldata_/01 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/01

Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000

Checking if permissions on /eniq/data/etldata_/01 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/01 to 0755
	
Checking if directory /eniq/data/etldata_/02 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/02
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/02 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/02 to 0755
	
Checking if directory /eniq/data/etldata_/03 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/etldata_/03
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/etldata_/03 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/etldata_/03 to 0755
	
Checking if directory /eniq/data/pmdata is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is successfully changed on Reader2 
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata to 0755
	
Checking if directory /eniq/data/pmdata/eventdata is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata
	
Checking if ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata to 0755

Checking if directory /eniq/data/pmdata/eventdata/00 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/00
	
Checking if ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/00 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/00 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/00 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/01 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/01
	
Checking if ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/01 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/01 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/01 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/02 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/02
	
Checking if ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/02 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/02 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/02 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/03 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/03
	
Checking if ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/03 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/03 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/03 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/04 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/04
	
Checking if ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/04 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/04 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/04 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/05 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/05
	
Checking if ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/05 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/05 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/05 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/06 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/06
	
Checking if ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/06 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/06 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/06 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/07 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/07
	
Checking if ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/07 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/07 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/07 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/08 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/08
	
Checking if ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/08 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/08 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/08 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/09 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/09
	
Checking if ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/09 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/09 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/09 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/10 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/10
	
Checking if ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/10 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/10 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/10 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/11 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/11
	
Checking if ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/11 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/11 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/11 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/12 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/12
	
Checking if ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/12 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/12 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/12 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/13 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/13
	
Checking if ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/13 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/13 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/13 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/14 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/14
	
Checking if ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/14 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/14 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/14 to 0755
	
Checking if directory /eniq/data/pmdata/eventdata/15 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata/eventdata/15
	
Checking if ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata/eventdata/15 to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata/eventdata/15 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata/eventdata/15 to 0755
	
Checking if directory /eniq/data/rejected is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/rejected
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if permissions on /eniq/data/rejected to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/rejected to 0755
	
Checking if directory /eniq/database/dwh_main is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main
	
Checking if ownership of /eniq/database/dwh_main to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main to 0755
	
Checking if directory /eniq/glassfish is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/glassfish
	
Checking if ownership of /eniq/glassfish to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/glassfish to dcuser:dc5000
	
Checking if permissions on /eniq/glassfish to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/glassfish to 0755
	
Checking if directory /eniq/home is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/home
	
Checking if ownership of /eniq/home to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000
	
Checking if permissions on /eniq/home to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/home to 0755
	
Checking if directory /eniq/log is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/log
	
Checking if ownership of /eniq/log to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if permissions on /eniq/log to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/log to 0755
	
Checking if directory /eniq/mediation_sw is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_sw
	
Checking if ownership of /eniq/mediation_sw to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_sw to dcuser:dc5000
	
Checking if permissions on /eniq/mediation_sw to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_sw to 0755
	
Checking if directory /eniq/mediation_inter is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/mediation_inter
	
Checking if ownership of /eniq/mediation_inter to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/mediation_inter to dcuser:dc5000

Checking if permissions on /eniq/mediation_inter to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/mediation_inter to 0755
	
Checking if directory /eniq/sentinel is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sentinel
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if permissions on /eniq/sentinel to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sentinel to 0755
	
Checking if directory /eniq/smf is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/smf
	
Checking if ownership of /eniq/smf to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/smf to dcuser:dc5000
	
Checking if permissions on /eniq/smf to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/smf to 0755
	
Checking if directory /eniq/snapshot is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/snapshot
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if permissions on /eniq/snapshot to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/snapshot to 0755
	
Checking if directory /eniq/sql_anywhere is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sql_anywhere
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if permissions on /eniq/sql_anywhere to 1777 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sql_anywhere to 1777
	
Checking if directory /eniq/sybase_iq is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sybase_iq
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if permissions on /eniq/sybase_iq to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sybase_iq to 0755
	
Checking if directory /eniq/sw is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if permissions on /eniq/sw to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw to 0755
	
Checking if directory /eniq/sw/bin is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/bin
	
Checking if ownership of /eniq/sw/bin to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/bin to dcuser:dc5000
	
Checking if permissions on /eniq/sw/bin to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/bin to 0755
	
Checking if directory /eniq/sw/conf is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/conf
	
Checking if ownership of /eniq/sw/conf to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/conf to dcuser:dc5000
	
Checking if permissions on /eniq/sw/conf to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/conf to 0755
	
Checking if directory /eniq/sw/installer is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/installer
	
Checking if ownership of /eniq/sw/installer to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/installer to dcuser:dc5000
	
Checking if permissions on /eniq/sw/installer to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/installer to 0755
	
Checking if directory /eniq/sw/log is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/log
	
Checking if ownership of /eniq/sw/log to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/log to dcuser:dc5000
	
Checking if permissions on /eniq/sw/log to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/log to 0755
	
Checking if directory /eniq/sw/platform is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/platform
	
Checking if ownership of /eniq/sw/platform to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/platform to dcuser:dc5000
	
Checking if permissions on /eniq/sw/platform to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/platform to 0755
	
Checking if directory /eniq/sw/runtime is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/sw/runtime
	
Checking if ownership of /eniq/sw/runtime to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw/runtime to dcuser:dc5000
	
Checking if permissions on /eniq/sw/runtime to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/sw/runtime to 0755
	
Checking if directory /eniq/upgrade is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/upgrade
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if permissions on /eniq/upgrade to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/upgrade to 0755
	
Checking if directory /eniq/database/rep_main is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_main
	
Checking if ownership of /eniq/database/rep_main to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_main to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_main to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_main to 0755
	
Checking if directory /eniq/database/rep_temp is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/rep_temp
	
Checking if ownership of /eniq/database/rep_temp to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/rep_temp to dcuser:dc5000
	
Checking if permissions on /eniq/database/rep_temp to 1755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/rep_temp to 1755
	
Checking if directory /eniq/data/reference is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/reference
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if permissions on /eniq/data/reference to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/reference to 0755
	
Checking if directory /eniq/northbound is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound
	
Checking if ownership of /eniq/northbound to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound to dcuser:dc5000
	
Checking if permissions on /eniq/northbound to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound to 0755
	
Checking if directory /eniq/northbound/lte_event_stat_file is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_stat_file
	
Checking if ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_stat_file to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_stat_file to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_stat_file to 0755
	
Checking if directory /eniq/data/pushData is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData
	
Checking if permissions on /eniq/data/pushData to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData to 0775
	
Checking if directory /eniq/data/pushData/00 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/00
	
Checking if permissions on /eniq/data/pushData/00 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/00 to 0775
	
Checking if directory /eniq/data/pushData/01 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/01
	
Checking if permissions on /eniq/data/pushData/01 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/01 to 0775
	
Checking if directory /eniq/data/pushData/02 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/02
	
Checking if permissions on /eniq/data/pushData/02 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/02 to 0775
	
Checking if directory /eniq/data/pushData/03 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/03
	
Checking if permissions on /eniq/data/pushData/03 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/03 to 0775
	
Checking if directory /eniq/data/pushData/04 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/04
	
Checking if permissions on /eniq/data/pushData/04 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/04 to 0775
	
Checking if directory /eniq/data/pushData/05 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/05
	
Checking if permissions on /eniq/data/pushData/05 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/05 to 0775
	
Checking if directory /eniq/data/pushData/06 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/06
	
Checking if permissions on /eniq/data/pushData/06 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/06 to 0775
	
Checking if directory /eniq/data/pushData/07 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/07
	
Checking if permissions on /eniq/data/pushData/07 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/07 to 0775
	
Checking if directory /eniq/data/pushData/08 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/08

Checking if permissions on /eniq/data/pushData/08 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/08 to 0775
	
Checking if directory /eniq/data/pushData/09 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/09
	
Checking if permissions on /eniq/data/pushData/09 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/09 to 0775
	
Checking if directory /eniq/data/pushData/10 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/10
	
Checking if permissions on /eniq/data/pushData/10 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/10 to 0775
	
Checking if directory /eniq/data/pushData/11 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/11
	
Checking if permissions on /eniq/data/pushData/11 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/11 to 0775
	
Checking if directory /eniq/data/pushData/12 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/12
	
Checking if permissions on /eniq/data/pushData/12 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/12 to 0775
	
Checking if directory /eniq/data/pushData/13 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/13
	
Checking if permissions on /eniq/data/pushData/13 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/13 to 0775
	
Checking if directory /eniq/data/pushData/14 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/14
	
Checking if permissions on /eniq/data/pushData/14 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/14 to 0775
	
Checking if directory /eniq/data/pushData/15 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pushData/15
	
Checking if permissions on /eniq/data/pushData/15 to 0775 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pushData/15 to 0775
	
Checking if directory /eniq/misc/ldap_db is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/misc/ldap_db
	
Checking if ownership of /eniq/misc/ldap_db to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/misc/ldap_db to dcuser:dc5000
	
Checking if permissions on /eniq/misc/ldap_db to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/misc/ldap_db to 0755
	
Checking if directory /eniq/export is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/export
	
Checking if ownership of /eniq/export to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/export to dcuser:dc5000
	
Checking if permissions on /eniq/export to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/export to 0755
	
Checking if directory /eniq/fmdata is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/fmdata
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if permissions on /eniq/fmdata to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/fmdata to 0755
	
Checking if directory /eniq/database is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database
	
Checking if ownership of /eniq/database to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database to dcuser:dc5000
	
Checking if permissions on /eniq/database to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace

Checking if ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace
	
Checking if ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace to 1755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace to 1755
	
Checking if directory /eniq/database/dwh_reader is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_reader
	
Checking if ownership of /eniq/database/dwh_reader to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_reader to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_reader to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_reader to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_1 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_2 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_3 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_4 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_5 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_6 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_6
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_6 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_6 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_7 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_7
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_7 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_7 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_8 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_8
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_8 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_8 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_9 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_9
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_9 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_9 to 0755
	
Checking if directory /eniq/database/dwh_main_dbspace/dbspace_dir_10 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_main_dbspace/dbspace_dir_10
	
Checking if ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_main_dbspace/dbspace_dir_10 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_main_dbspace/dbspace_dir_10 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_1
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_1 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_2
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_2 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_3
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_3 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_4
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_4 to 0755
	
Checking if directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5 is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/database/dwh_temp_dbspace/dbspace_dir_5
	
Checking if ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to dcuser:dc5000
	
Checking if permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/database/dwh_temp_dbspace/dbspace_dir_5 to 0755
	
Checking if directory /eniq/northbound/lte_event_ctrs_symlink is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/northbound/lte_event_ctrs_symlink
	
Checking if ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/northbound/lte_event_ctrs_symlink to dcuser:dc5000
	
Checking if permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/northbound/lte_event_ctrs_symlink to 0755
	
Checking if directory /eniq/data/pmdata_soem is successfully created on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Creating directory /eniq/data/pmdata_soem
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_soem to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_soem to 0755
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if permissions on /eniq/data/pmdata_sim to 0755 is successfully changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing permissions on /eniq/data/pmdata_sim to 0755
	
Checking if ownership of /eniq/admin to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/admin to dcuser:dc5000
	
Checking if ownership of /eniq/archive to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/archive to dcuser:dc5000
	
Checking if ownership of /eniq/backup to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/backup to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata to dcuser:dc50000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/00 to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/00 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/01 to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/01 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/02 to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/02 to dcuser:dc5000
	
Checking if ownership of /eniq/data/etldata_/03 to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/etldata_/03 to dcuser:dc5000
	
Checking if ownership of /eniq/fmdata to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/fmdata to dcuser:dc5000
	
Checking if ownership of /eniq/home to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/home to dcuser:dc5000

Checking if ownership of /eniq/log to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/log to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata to dcuser:dc5000
	
Checking if ownership of /eniq/data/reference to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/reference to dcuser:dc5000
	
Checking if ownership of /eniq/data/rejected to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/rejected to dcuser:dc5000
	
Checking if ownership of /eniq/sentinel to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sentinel to dcuser:dc5000
	
Checking if ownership of /eniq/snapshot to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/snapshot to dcuser:dc5000
	
Checking if ownership of /eniq/sql_anywhere to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sql_anywhere to dcuser:dc5000
	
Checking if ownership of /eniq/sybase_iq to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sybase_iq to dcuser:dc5000
	
Checking if ownership of /eniq/sw to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/sw to dcuser:dc5000
	
Checking if ownership of /eniq/upgrade to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/upgrade to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_soem to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_soem to dcuser:dc5000
	
Checking if ownership of /eniq/data/pmdata_sim to dcuser:dc5000 is changed on Reader2
    [Tags]                        Upgrade  MB
    Should Contain                ${UG_MB_Log}                 Changing ownership of /eniq/data/pmdata_sim to dcuser:dc5000
	
Checking if required directories are successfully created on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully created required directories
	Should Be Equal As Strings    ${count}                   4
	
Checking if stage - install_backup_sw is successfully entered on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Entering core install stage - install_backup_sw
	Should Be Equal As Strings    ${count}                   4
	
Checking if SW to /eniq/bkup_sw is successfully installed on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully installed SW to /eniq/bkup_sw
	Should Be Equal As Strings    ${count}                   4
	
Checking if stage - install_connectd_sw is successfully entered on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Entering core install stage - install_connectd_sw
	Should Be Equal As Strings    ${count}                   4
	
Checking if SW to /eniq/connectd is successfully installed on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully installed SW to /eniq/connectd
	Should Be Equal As Strings    ${count}                   4
	
Checking if stage - add_alias_details_to_service_names is successfully entered on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Entering core install stage - add_alias_details_to_service_names
	Should Be Equal As Strings    ${count}                   4
	
Checking if NAS alias information in /etc/hosts is successfully updated on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully updated NAS alias information in /etc/hosts
	Should Be Equal As Strings    ${count}                   4
	
Checking if stage - install_rolling_snapshot is successfully entered on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Entering core install stage - install_rolling_snapshot
	Should Be Equal As Strings    ${count}                   4
	
Checking if rolling snapshots are successfully created on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully created rolling snapshots
	Should Be Equal As Strings    ${count}                   4
	
Checking if stage - cleanup is successfully entered on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Entering core install stage - cleanup
	Should Be Equal As Strings    ${count}                   4
	
Checking if ENIQ cleanup stage is successfully completed on all blades
    [Tags]                        Upgrade  MB
    ${count}=                     Get Count                  ${UG_MB_Log}              Successfully completed ENIQ cleanup stage
	Should Be Equal As Strings    ${count}                   4

Checking file not found error in logs
    [Tags]                        Upgrade  MB
    ${count}=                  Get Count                ${UG_MB_Log}                    tomcat_users_history.properties: No such file or directory
    Should Contain X Times     ${UG_MB_Log}             No such file or directory       ${count}
