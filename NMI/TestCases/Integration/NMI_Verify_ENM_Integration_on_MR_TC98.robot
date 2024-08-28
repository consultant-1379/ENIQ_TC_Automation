*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if mountpoint and IP information is collected
    [Tags]                 Integration  MR
    ${ENM-MR}=             Get File               ENM-Integration-MR.log
    Set Global Variable    ${ENM-MR}
    Should Contain         ${ENM-MR}              Mountpoint and IP information as supplied by user for Symlink directories are collected

Checking if mount_server.bsh is successfully executed
    [Tags]             Integration  MR
    Should Contain     ${ENM-MR}                 Successfully completed /eniq/connectd/bin/mount_server.bsh

Checking if NAS parameters are entered
    [Tags]             Integration  MR
    Should Contain     ${ENM-MR}                 Getting NAS parameters for filesystem creation

Checking if NAS file system is created
    [Tags]             Integration  MR
    Should Contain     ${ENM-MR}                 Creating new NAS file system

Checking if symlink is created
    [Tags]             Integration  MR
    Should Contain     ${ENM-MR}                 Created symlink

Checking if ENM is successfully configured
    [Tags]             Integration  MR
    Should Contain     ${ENM-MR}                 Successfully configured ENM

Checking if OSS mount configuration is successfully completed
    [Tags]             Integration  MR
    Should Contain     ${ENM-MR}                 Successfully completed OSS Mount Configuration
