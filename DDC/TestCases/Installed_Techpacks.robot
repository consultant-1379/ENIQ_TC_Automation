*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for techpack_list file in Techpack source TC01
    [Documentation]      Checking for techpack_list_${date_Y-m-d}.txt file in /eniq/log/assureddc/techpack directory
    [Tags]               Installed_Techpacks
    Check File Exists    /eniq/log/assureddc/techpack/techpack_list_${date_Y-m-d}.txt

Checking for techpack_list file size in Techpack source TC02
    Depends on test      Checking for techpack_list file in Techpack source TC01
    [Documentation]      Checking for non empty techpack_list_${date_Y-m-d}.txt file in /eniq/log/assureddc/techpack directory
    [Tags]               Installed_Techpacks
    Check File Size      /eniq/log/assureddc/techpack/techpack_list_${date_Y-m-d}.txt

Checking for techpack_list file in Techpack destination TC03
    Depends on test      Checking for techpack_list file size in Techpack source TC02
    [Documentation]      Checking for techpack_list_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_techpacks directory
    [Tags]               Installed_Techpacks
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_techpacks/techpack_list_${date_Y-m-d}.txt

Checking for techpack_list file size in Techpack destination TC04
    Depends on test      Checking for techpack_list file in Techpack destination TC03
    [Documentation]      Checking for non empty techpack_list_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_techpacks directory
    [Tags]               Installed_Techpacks
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/installed_techpacks/techpack_list_${date_Y-m-d}.txt

Checking for query file in Techpack source TC05
    [Documentation]      Checking for query_file.sql file in /eniq/log/assureddc/techpack directory
    [Tags]               Installed_Techpacks
    Check File Exists    /eniq/log/assureddc/techpack/query_file.sql

Checking for query file size in Techpack source TC06
    Depends on test      Checking for query file in Techpack source TC05
    [Documentation]      Checking for query_file.sql file in /eniq/log/assureddc/techpack directory
    [Tags]               Installed_Techpacks
    Check File Size      /eniq/log/assureddc/techpack/query_file.sql
