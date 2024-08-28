*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if mountpoint and IP information is collected
    [Tags]             Integration  SB
	${ENM_SB_Log}=     Get File                   ENM-Integration-SB.log
	Set Global Variable      ${ENM_SB_Log}
    Should Contain     ${ENM_SB_Log}              Mountpoint and IP information as supplied by user for Symlink directories are collected
	
Checking if mount_server.bsh is successfully executed
    [Tags]             Integration  SB
    Should Contain     ${ENM_SB_Log}                 Successfully completed /eniq/connectd/bin/mount_server.bsh
	
Checking if NAS parameters are entered
    [Tags]             Integration  SB
    Should Contain     ${ENM_SB_Log}                 Getting NAS parameters for filesystem creation
	
Checking if NAS file system is created
    [Tags]             Integration  SB
    Should Contain     ${ENM_SB_Log}                 Creating new NAS file system
	
Checking if symlink is created
    [Tags]             Integration  SB
    Should Contain     ${ENM_SB_Log}                 Created symlink
	
Checking if ENM is successfully configured
    [Tags]             Integration  SB
    Should Contain     ${ENM_SB_Log}                 Successfully configured ENM
	
Checking if OSS mount configuration is successfully completed
    [Tags]             Integration  SB
    Should Contain     ${ENM_SB_Log}                 Successfully completed OSS Mount Configuration
