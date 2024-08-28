*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if mountpoint and IP information is collected
    [Tags]             Integration  Rack
    ${ENM_Rack_Log}=   Get File                   ENM-Integration-Rack.log
	Set Global Variable      ${ENM_Rack_Log}
    Should Contain     ${ENM_Rack_Log}            Mountpoint and IP information as supplied by user for Symlink directories are collected
	
Checking if mount_server.bsh is successfully executed
    [Tags]             Integration  Rack
    Should Contain     ${ENM_Rack_Log}                 Successfully completed /eniq/connectd/bin/mount_server.bsh
	
Checking if LVM file system is created
    [Tags]             Integration  Rack
    Should Contain     ${ENM_Rack_Log}                 Creating new LVM file system
	
Checking if logical volume is mounted
    [Tags]             Integration  Rack
    Should Contain     ${ENM_Rack_Log}                 Mounting Logical Volume
	
Checking if ENM is successfully configured
    [Tags]             Integration  Rack
    Should Contain     ${ENM_Rack_Log}                 Successfully configured ENM
	
Checking if OSS mount configuration is successfully completed
    [Tags]             Integration  Rack
    Should Contain     ${ENM_Rack_Log}                 Successfully completed OSS Mount Configuration
