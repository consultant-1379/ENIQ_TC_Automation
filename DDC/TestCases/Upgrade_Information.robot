*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for upgrade_timing_detail_log file in Upgrade Information source TC01
    [Documentation]         Checking for upgrade_timing_detail_log.txt file in /eniq/log/assureddc/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Exists       /eniq/log/assureddc/upgrade_time/upgrade_timing_detail_log.txt

Checking for upgrade_timing_detail_log file size in Upgrade Information source TC02
    Depends on test         Checking for upgrade_timing_detail_log file in Upgrade Information source TC01
    [Documentation]         Checking for non empty upgrade_timing_detail_log.txt file in /eniq/log/assureddc/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Size         /eniq/log/assureddc/upgrade_time/upgrade_timing_detail_log.txt

Checking for upgrade_timing_detail_log file in Upgrade Information destination TC03
    Depends on test         Checking for upgrade_timing_detail_log file size in Upgrade Information source TC02
    [Documentation]         Checking for upgrade_timing_detail_log.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Exists       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/upgrade_timing_detail_log.txt

Checking for upgrade_timing_detail_log file size in Upgrade Information destination TC04
    Depends on test         Checking for upgrade_timing_detail_log file in Upgrade Information destination TC03
    [Documentation]         Checking for non empty upgrade_timing_detail_log.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Size         /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/upgrade_timing_detail_log.txt

Checking for features_name_list_log file in Upgrade Information source TC05
    [Documentation]         Checking for features_name_list_log.txt file in /eniq/log/assureddc/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Exists       /eniq/log/assureddc/upgrade_time/features_name_list_log.txt

Checking for features_name_list_log file size in Upgrade Information source TC06
    Depends on test         Checking for features_name_list_log file in Upgrade Information source TC05
    [Documentation]         Checking for non empty features_name_list_log.txt file in /eniq/log/assureddc/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Size         /eniq/log/assureddc/upgrade_time/features_name_list_log.txt

Checking for features_name_list_log file in Upgrade Information destination TC07
    Depends on test         Checking for features_name_list_log file size in Upgrade Information source TC06
    [Documentation]         Checking for features_name_list_log.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Exists       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/features_name_list_log.txt

Checking for features_name_list_log file size in Upgrade Information destination TC08
    Depends on test         Checking for features_name_list_log file in Upgrade Information destination TC07
    [Documentation]         Checking for non empty features_name_list_log.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Size         /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/features_name_list_log.txt

Checking for missing_upgrade_logs file in Upgrade Information source TC09
    [Documentation]         Checking for missing_upgrade_logs.txt file in /eniq/log/assureddc/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Exists       /eniq/log/assureddc/upgrade_time/missing_upgrade_logs.txt

Checking for missing_upgrade_logs file size in Upgrade Information source TC10
    Depends on test         Checking for missing_upgrade_logs file in Upgrade Information source TC09
    [Documentation]         Checking for non empty missing_upgrade_logs.txt file in /eniq/log/assureddc/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Size         /eniq/log/assureddc/upgrade_time/missing_upgrade_logs.txt

Checking for missing_upgrade_logs file in Upgrade Information destination TC11
    Depends on test         Checking for missing_upgrade_logs file size in Upgrade Information source TC10
    [Documentation]         Checking for missing_upgrade_logs.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Exists       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/missing_upgrade_logs.txt

Checking for missing_upgrade_logs file size in Upgrade Information destination TC12
    Depends on test         Checking for missing_upgrade_logs file in Upgrade Information destination TC11
    [Documentation]         Checking for non empty missing_upgrade_logs.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
    [Tags]                  Upgrade_Information
    Check File Size         /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/missing_upgrade_logs.txt

#Checking for upgrade_server_type_info file in Upgrade Information source
#   [Documentation]         Checking for upgrade_server_type_info.txt file in /eniq/log/assureddc/upgrade_time directory
#   [Tags]                  Upgrade_Information
#    Check File Exists       /eniq/log/assureddc/upgrade_time/upgrade_server_type_info.txt

#Checking for upgrade_server_type_info file size in Upgrade Information source
#    Depends on test         Checking for upgrade_server_type_info file in Upgrade Information source
#    [Documentation]         Checking for non empty upgrade_server_type_info.txt file in /eniq/log/assureddc/upgrade_time directory
#    [Tags]                  Upgrade_Information
#   Check File Size         /eniq/log/assureddc/upgrade_time/upgrade_server_type_info.txt

#Checking for upgrade_server_type_info file in Upgrade Information destination
#    Depends on test         Checking for upgrade_server_type_info file size in Upgrade Information source
#    [Documentation]         Checking for upgrade_server_type_info.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
#    [Tags]                  Upgrade_Information
#    Check File Exists       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/upgrade_server_type_info.txt

#Checking for upgrade_server_type_info file size in Upgrade Information destination
#    Depends on test         Checking for upgrade_server_type_info file in Upgrade Information destination
#    [Documentation]         Checking for non empty upgrade_server_type_info.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time directory
#    [Tags]                  Upgrade_Information
#    Check File Size         /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/upgrade_time/upgrade_server_type_info.txt
