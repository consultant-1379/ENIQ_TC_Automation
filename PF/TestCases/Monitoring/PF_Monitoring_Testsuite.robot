*** Settings ***
Documentation     Testing Monitoring
Resource    ./PF_Monitoring_01-03_Verify_and intall_latest_module_deployed_in_ENIQ_Server.robot
Resource    ./PF_Monitoring_04_Verify_latest_module_in_CLI.robot
Resource    ./PF_Monitoring_05_Verify_Latest_module_in_Adminui.robot
Resource    ./PF_Monitoring_06_Verify_platform_Installer_Logs.robot
Resource    ./PF_Monitoring_07_Verify_the_data_loading_status_using_adminui.robot
Resource    ./PF_Monitoring_09_Verify_the_data_loading_in_database_using_CLI.robot
Resource    ./PF_Monitoring_12_Verify_the_aggregation_in_database_using_CLI.robot
Resource    ./PF_Monitoring_14_Verify_DWH_Monitor_sets_using_adminui.robot
Resource    ./PF_Monitoring_16_Verify_update_monitoring_set_using_adminui.robot
Resource    ./PF_Monitoring_17_Verify_at_which_interval_the_update_monitoring_set_is_running.robot
Resource    ./PF_Monitoring_18_Verify_the_monitor_heap_bsh_and_monitor_cache_usage_bsh_scripts_using_CLI.robot
 
 
*** Test Cases ***
TC_01-03 Verify and intall the latest module deployed in ENIQ_server
    Verify and intall the latest module deployed in ENIQ_server
   
 
 
TC_04 Verify latest module in CLI
    Verify latest module in CLI
 
 
TC_05 Verify latest module in AdminUI
    Verify latest module in AdminUI
 
 
   
TC_06 Verify the installation logs for no errors
    Verify the installation logs for no errors
 
TC_07 Verify the data loading status using adminui
    Verify the data loading status using adminui
 
TC_09 Verify the data loading in database using CLI
    Verify the data loading in database using CLI
 
TC_12 Verify the aggregation in database using CLI
    Verify the aggregation in database using CLI
 
 
TC_14 Verify all the DWH_MONITOR sets using adminui
    Verify all the DWH_MONITOR sets using adminui
 
 
TC_16 Verify the update monitoring set using adminui
    Verify the update monitoring set using adminui
 
 
TC_17 Verify at which interval the update monitoring set is running
    Verify at which interval the update monitoring set is running
 
 
TC_18 Verify monitor_heap.bsh and monitor_cache_usage.bsh scripts using CLI
    Verify monitor_heap.bsh and monitor_cache_usage.bsh scripts using CLI
 