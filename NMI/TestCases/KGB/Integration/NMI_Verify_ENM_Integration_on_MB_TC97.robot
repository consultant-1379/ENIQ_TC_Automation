*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if mountpoint and IP information is collected
    [Tags]             Integration  MB
	${ENM_MB_Log}=     Get File                   ENM-Integration-MB.log
	Set Global Variable      ${ENM_MB_Log}
    Should Contain     ${ENM_MB_Log}              Mountpoint and IP information as supplied by user for Symlink directories are collected
	
Checking if mount_server.bsh is successfully executed
    [Tags]             Integration  MB
    Should Contain     ${ENM_MB_Log}                 Successfully completed /eniq/connectd/bin/mount_server.bsh
	
Checking if NAS parameters are entered
    [Tags]             Integration  MB
    Should Contain     ${ENM_MB_Log}                 Getting NAS parameters for filesystem creation
	
Checking if NAS file system is created
    [Tags]             Integration  MB
    Should Contain     ${ENM_MB_Log}                 Creating new NAS file system
	
Checking if symlink is created
    [Tags]             Integration  MB
    Should Contain     ${ENM_MB_Log}                 Created symlink
	
Checking if ENM is successfully configured
    [Tags]             Integration  MB
    Should Contain     ${ENM_MB_Log}                 Successfully configured ENM
	
Checking if OSS mount configuration is successfully completed
    [Tags]             Integration  MB
    Should Contain     ${ENM_MB_Log}                 Successfully completed OSS Mount Configuration
