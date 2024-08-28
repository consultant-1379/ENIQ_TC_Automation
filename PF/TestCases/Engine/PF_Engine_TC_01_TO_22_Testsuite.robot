*** Settings ***
Library    SSHLibrary
Library             String
Library             Collections
Library    DateTime
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/repdb_connection.robot
Suite Setup    Connect to server as a dcuser          
Suite Teardown      Close All Connections


*** Test Cases ***
TC_01 Verify installation logs for no errors
    Cli.Connect to server as a dcuser
    Go to the folder    ${platform_installer}
    ${latest_file}=    Get latest file from directory    engine*
    #Negative Scenario 0 arg, like error, warning, exception, failed
    #Positive Scenario 1 arg, like Success, created, passed
    Validate the log file for    ${no_error_warning_exception_failed}    ${latest_file}    0
    #[Teardown]    Test Teardown

TC_02 Verify installation logs for successful installation
    Connect to server as a dcuser 
    Go to the folder    ${platform_installer}
    ${latest_file}=    Get latest file from directory    engine*
    #Negative Scenario 0 arg, like error, warning, exception, failed
    #Positive Scenario 1 arg, like Success, created, passed
    ${output}=    Validate the log file for   ${successfully_installation}    ${latest_file}    1
    Verify the log file containing    ${output}    @{successful_msg}
    #[Teardown]    Test Teardown


TC_03 Verify the engine services for active and loaded
    Open connection as root user
    ${output}=    Execute the command    ${engine_service_status}
    Validate the output    ${output}    Loaded: loaded
    Validate the output    ${output}    active (running)
    #[Teardown]    Test Teardown


TC_04 Verify the engine service in Adminui page 
    Launch the AdminUI page in browser
    Login to Adminui
    Click Button    System Status
    Verify the System Status page displayed
    Click on Engine Status link
    Switch window to new Engine status details tab
    Click on scroll down button
    Verify the engine service in AdminUI page
    Switch window to back to Adminui tab
    Click on scroll down button
    Logout from Adminui
    #[Teardown]    Test teardown

TC_05 Verify the engine profile can be set to NoLoads
    Connect to server as a dcuser	
    ${output}=    Execute the command    engine -e changeProfile NoLoads
    Validate the output    ${output}    Change profile requested successfully
    Validate the output    ${output}    ${profile_noloads}

    ${output}=    Execute the command    engine -e changeProfile Normal
    Validate the output    ${output}    Change profile requested successfully
    Validate the output    ${output}    ${profile_normal}
    #[Teardown]    Test Teardown


TC_06 Verify the command engine -e loggingStatus
    Connect to server as a dcuser
    ${logging_status}=    Execute the command    engine -e loggingStatus
    Sleep    30s
    Verify the msg    ${logging_status}    Querying logging status   
    Verify the msg    ${logging_status}    Logging status printed succesfully
    #[Teardown]    Test Teardown

TC_07 Verify the Starter license check
    Connect to server as a dcuser
    ${output}=    Execute the command    ${license_manager_Network_IQ_Starter}
    Validate the output    ${output}    ${license_manager_expire_date}
    Verify license expire date    ${output}
    #[Teardown]    Test Teardown

TC_08 Verify the validity of license
    Connect to server as a dcuser	
    ${output}=    Execute the command    ${license_manager_IQ_Eniq_Capacity}
    Validate the output    ${output}    ${license_manager_expire_date}
    Verify license expire date    ${output}
    #[Teardown]    Test Teardown

TC_09 Verify the engine status
    Connect to server as a dcuser
    ${output}=    Execute the command    engine status
    Validate the output    ${output}    Current Profile: Normal
    Validate the output    ${output}    engine is running OK
    Validate the output    ${output}    lwp helper is running
    #[Teardown]    Test Teardown
    
TC_10 verify the engine current profile
    Connect to server as a dcuser
    ${output}=    Execute the command    engine -e getCurrentProfile
    Validate the output    ${output}    Normal
    #[Teardown]    Test Teardown

TC_11 Verify the command engine -e showActiveInterfaces based on the eniq aliases if multiple ENM connected
    Connect to server as a dcuser
    ${cmd_output}=   Execute the commands    engine -e showActiveInterfaces
    Verify 'Getting Active Interfaces' is displayed    ${cmd_output}    
    Verify Active Interface is listed
    @{enm_list}=    Get the number of ENM Connections
    Verify the Active Interfaces for multiple ENM connections    @{enm_list}
    #[Teardown]    Test Teardown

TC_12 Verify the command engine -e disableSet
    Connect to physical server
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${etlrep_pwd}=    Execute Command     ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    ${Adapter_INTF}=    Execute the Command    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Adapter_INTF%');\ngo\n" | isql -P ${etlrep_pwd} -U etlrep -S repdb -b
    @{spilting_techpack}=    Split To Lines    ${Adapter_INTF}    3
    ${Techpack_list}=    Get From List    ${spilting_techpack}    3
    ${Techpack_name}=    Get Regexp Matches    ${Techpack_list}    INTF_[a-zA-Z]+_[a-zA-Z]+_[a-zA-Z]+
    ${interface_name}=    Get From List    ${Techpack_name}    0
    ${disable_set}=    Executing the command    ${engine_disableset_techpack} ${interface_name} ${Techpack_list} 
    Verification of disable Sets    ${disable_set}    Disabled Sets
    Verify the msg    ${disable_set}    Completed successfully
    ${show_disabledsets}=    Executing the command    ${engine_showdisable_sets}  
    Verify the msg    ${show_disabledsets}    Completed successfully
    ${start_set}=    Executing the command    ${engine_disableset_techpack} ${interface_name} ${Techpack_list}
    Verification of disable Sets    ${start_set}        Disabled Sets
    Verify the msg    ${start_set}    Completed successfully

TC_13 Verify the command engine -e enableSet
    Connect to physical server
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${etlrep_pwd}=    Execute Command     ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    ${Adapter_INTF}=    Execute the Command    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Adapter_INTF%');\ngo\n" | isql -P ${etlrep_pwd} -U etlrep -S repdb -b
    @{spilting_techpack}=    Split To Lines    ${Adapter_INTF}    3
    ${Techpack_list}=    Get From List    ${spilting_techpack}    3
    ${Techpack_name}=    Get Regexp Matches    ${Techpack_list}    INTF_[a-zA-Z]+_[a-zA-Z]+_[a-zA-Z]+
    ${interface_name}=    Get From List    ${Techpack_name}    0
    ${engine_enable_set}=    Executing the command    ${engine_enableset} ${interface_name} ${Techpack_list}
    Verification of enable Sets    ${engine_enable_set}    Disabled Sets
    Verify the msg    ${engine_enable_set}    Completed successfully    
    #[Teardown]    Test Teardown

*** Test Cases ***
TC_14 Verify the incorrect command for engine -e restart
    Connect to server as a dcuser
    ${engine_restart_status}=    Execute the command    ${engine_restart}
    Sleep    25s  
    Verify the error msg    ${engine_restart_status}    Invalid command entered: restart
    Verify the error msg    ${engine_restart_status}    Execute failed
    #[Teardown]    Test Teardown

TC_15 Verify the incorrect command for engine -e stop
    Connect to server as a dcuser
    ${engine_stop_status}=    Execute the command    ${engine_stop}
    Verify the error msg    ${engine_stop_status}    Execute failed
    Execute the command    ${Engine_logs_path}
    ${engine_stop_log}=    Grep message from file    error    stop_engine_*.log
    ${engine_stop_log}=    Grep message from file    execption    stop_engine_*.log
    #[Teardown]    Test Teardown

TC_16 Verify the incorrect command for engine -e start
    Connect to server as a dcuser
    ${enginestart_status}=    Execute the command    ${engine_start}   
    Verify the error msg    ${enginestart_status}    Invalid command entered: start
    Verify the error msg    ${enginestart_status}    Execute failed
    Execute the command    ${Engine_logs_path}
    ${engine_stop_log}=    Grep message from file    error    stop_engine_*.log
    ${engine_stop_log}=    Grep message from file    execption    stop_engine_*.log
    #[Teardown]    Test Teardown

TC_17 Verify the command for engine -e status
    Connect to server as a dcuser
    ${engine_status}=    Execute Command    /eniq/sw/bin/engine -e status 
    Verify the msg    ${engine_status}    Execution Profile
    Verify the msg    ${engine_status}    Completed successfully
    #[Teardown]    Test Teardown

TC_18 Verify activation of interface
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    Remove log file
    Set Client Configuration    prompt=[eniq_stats] {dcuser} #:    timeout=900
    ${getting_activing_interfaces_01}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
    @{interface_01}=    Split To Lines    ${getting_activing_interfaces_01}
    ${Techpack_list_01}=    Get From List    ${interface_01}    1
    ${Techpack_selected_01}=    Running the script    ./activate_interface -o eniq_oss_1 -i${Techpack_list_01}
    Verify the msg    ${Techpack_selected_01}    Change profile requested successfully
    ${repdb_return_status}=    Run Keyword And Return Status    Verify eniq_oss_2 is present    
    IF    ${repdb_return_status} == True
        Go to the folder    ${installer_path}
        ${getting_activing_interfaces_02}=    Execute the Command    cd /eniq/sw/installer && ./get_active_interfaces | grep -i eniq_oss_2
        @{interface_02}=    Split To Lines    ${getting_activing_interfaces_02}
        ${Techpack_list_02}=    Get From List    ${interface_02}    1
        ${Techpack_selected_02}=    Running the script   ./activate_interface -o eniq_oss_2 -i${Techpack_list_02}
        Verify the msg    ${Techpack_selected_02}    Change profile requested successfully
        ${pm_data}=    Execute the command    cd /eniq/data/pmdata/ ; ls -lrth
        Verify the msg    ${pm_data}    eniq_oss_2
        Go to the folder    ${installer_path}
        ${getting_activing_interfaces_03}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
        @{deactive_interface-03}=    Split To Lines    ${getting_activing_interfaces_03}
        ${Techpack_list_03}=    Get From List    ${deactive_interface-03}    1
        ${Techpack_selected_03}=    Execute the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list_03}
        Verify the msg    ${Techpack_selected_03}    Starting to deactivate interfaces 

    ELSE
        Go to the folder    ${installer_path}
        ${getting_activing_interfaces_03}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
        @{deactive_interface-03}=    Split To Lines    ${getting_activing_interfaces_03}
        ${Techpack_list_03}=    Get From List    ${deactive_interface-03}    1
        ${Techpack_selected_03}=    Execute the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list_03}
        Verify the msg    ${Techpack_selected_03}    Starting to deactivate interfaces

    END

TC_19 Verify the interface deactivation
    Connect to physical server
    Go to the folder    ${installer_path}
    Remove log file
    Write    ./get_active_interfaces | grep -i eniq_oss_1
    ${getting_activing_interfaces}=    Read    delay=1s
    @{interface}=    Split To Lines    ${getting_activing_interfaces}
    ${Techpack_list}=    Get From List    ${interface}    1
    ${Techpack_selected_01}=    Executing the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list}
    Verify the msg    ${Techpack_selected_01}    Starting to deactivate interfaces
    ${Techpack_selected_02}=    Executing the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list}
    Verify the msg    ${Techpack_selected_02}    already deactivated

TC_20 Verify get active interface details
    Connect to server as a dcuser
    ${refernce_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file
    @{spliting_oss_ref_file}=    Split To Lines    ${refernce_file}
    FOR    ${refernce_file}    IN    @{spliting_oss_ref_file}
        
        ${Get_oss_file}=    Get Regexp Matches    ${refernce_file}    eniq_oss_\\d
        ${Techpack}=    Get From List    ${Get_oss_file}    0
        Execute the command    ${installer_path}
        ${interface_oss_ref_files}=    Execute the command    ${get_active_interfaces_01} ${Techpack}
        Verify the msg    ${interface_oss_ref_files}    ${Techpack}
        
        
    END

TC_21 Verify the command engine -e startSet
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${etlrep_pwd}=    Execute Command     ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    ${INTF_Loader}=    Execute the Command    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Loader%');\ngo\n" | isql -P ${etlrep_pwd} -U etlrep -S repdb -b
    @{spilting_techpack}=    Split To Lines    ${INTF_Loader}
    ${Techpack_list}=    Get From List    ${spilting_techpack}    15
    @{seperate_techpackname}=    Get Regexp Matches    ${Techpack_list}    DC_[a-zA-Z]*_[a-zA-Z]*
    ${Techpack_name}=    Get From List    ${seperate_techpackname}    0
    ${engine_startset}=    Execute the command    ${engine_startset_techpack} ${Techpack_name} ${Techpack_list}   
    Verify the msg    ${engine_startset}    Start set requested successfully
    Go to the folder    ${Engine_Logs}${Techpack_name} ; ls
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${grepError_results_1}=    Grep message from file    error    engine-${current_date}.log
    ${grepError_results_2}=    Grep message from file    exception    engine-${current_date}.log
    verify for no errors in logs    ${grepError_results_1}
    verify for no errors in logs    ${grepError_results_2}

TC_22 Verify the command engine -e removeTechPacksInPriorityQueue
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    ${getting_activing_interfaces}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
    @{spilting_interfaces}=    Split To Lines    ${getting_activing_interfaces}
    ${Techpack_list}=    Get From List    ${spilting_interfaces}    0
    ${remove_techpack}=    Execute the command    engine -e removeTechPacksInPriorityQueue${Techpack_list}
    Verify the error msg    ${remove_techpack}    Removed tech pack sets from queue
    Launch the AdminUI page in browser
    Login to Adminui
    Click Button    System Status
    Verify the System Status page displayed
    Click on link    ETLC Monitoring
    Verify the ETLC Monitoring page displayed    
    Verify the remove techpack in adminui page    ${Techpack_list}
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
Test teardown
    Capture Page Screenshot    
    Close Browser




















    





