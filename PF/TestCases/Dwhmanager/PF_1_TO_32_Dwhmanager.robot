*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/repdb_connection.robot

Suite setup       Suite setup steps
Suite Teardown    Close All Connections

*** Variables ***
${host_123}         ieatrcxb6080.athtem.eei.ericsson.se
*** Test Cases ***
TC_01_to_03 Verify the Installer version is updated in versiondb.properties
    ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
    ${dwhmanager_rstate_buildno_clearcase}    Get dwhmanager Rstate from clearcase    ${dwhmanager_file}
    Connect to server as a dcuser
    ${dwhmanager_rstate_buildno_server}    Get dwhmanager version from server
    ${rstate_status}    Verify the latest dwhmanager version is updated in versiondb.properties file    ${dwhmanager_rstate_buildno_clearcase}    ${dwhmanager_rstate_buildno_server}
    Set Global Variable    ${rstate_status}
    
TC_04 Verify latest module in CLI
    ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
    ${dwhmanager_rstate_buildno_clearcase}    Get dwhmanager Rstate from clearcase    ${dwhmanager_file}
    Connect to server as a dcuser
    ${dwhmanager_rstate_buildno_server}    Get dwhmanager version from server
    Should be equal    ${dwhmanager_rstate_buildno_clearcase}    ${dwhmanager_rstate_buildno_server}

TC_05 Verify latest module in AdminUI
    ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
    ${dwhmanager_rstate_buildno_clearcase}    Get dwhmanager Rstate from clearcase    ${dwhmanager_file}
    Connect to server as a dcuser
    ${rstate_buildno_server}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i dwhmanager
    ${output}    Remove String Using Regexp    ${rstate_buildno_server}    .*dwhmanager\\S
    Should Be Equal    ${dwhmanager_rstate_buildno_clearcase}    ${output}
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Go to system monitoring and select installed modules
    Page Should Contain    ${rstate_buildno_server}
    AdminUIWebUI.Logout from Adminui

TC_06 Verify the installation logs for no errors
    Connect to server as a dcuser
    AdminUIWebUI.Execute the Command    ${platform_installer}
    ${latest}=    Get latest file from directory    dwhmanager*.log
    ${latest}    Split String    ${latest}
    ${Verify}    ${rc}    Execute Command    ${platform_installer} && cat ${latest}[0] | grep -iE "warning\|exception\|severe\|not found\|error"    return_rc=true
    IF    ${rc}==0
        Fail    Failing the testcase, since log has some warning/error/exception/not found
    ELSE
        Log    Passing the testcase, since there is no warning/error/exception
    END

TC_07 Verify the db connections using CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    AdminUIWebUI.Execute the Command    dos2unix test.bsh
    ${Dwhrep_output}=    Connect to dwhrep in CLi
    AdminUIWebUI.Verify the msg    ${Dwhrep_output}    (dwhrep) 
    AdminUIWebUI.Execute the Command    Exit
    ${dc_output}=    Connect to dc username in CLI
    AdminUIWebUI.Verify the msg    ${dc_output}    (dc)
    AdminUIWebUI.Execute the Command    Exit
    ${etlrep_output}=    Connect to etlrep connection in CLI
    AdminUIWebUI.Verify the msg    ${etlrep_output}    (etlrep)
    AdminUIWebUI.Execute the Command    Exit

TC_08 Check status details of ENIQ DWH database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show status details in ENIQ DWH
    Verify the Dwh_manager status in adminui
    Page Should Contain Element    xpath://*/td[contains(text(),'Services Running')]/font[1][@color='green']
    navigate to database status detils window
    ${Build_time}=    Get Text    xpath://td[text()=' Build Time: ']/following-sibling::td
    Log To Console    ${Build_time}
    Should Not Be Empty    ${Build_time}
    Navigate to main page
    AdminUIWebUI.Logout from Adminui

TC_09 Check the connection information of adminui in ENIQ DWH database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show connection status details in ENIQ DWH
    navigate to IQ Connection status details window
    Page Should Contain    AdminUI    dc
    Page Should Contain    AdminUI    DBA
    Navigate to main page
    AdminUIWebUI.Logout from Adminui

TC_10 Check IQ Multiplex status details for ENIQ DWH database using adminui
    Connect to server as a dcuser
    ${deployement_type}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    Log To Console    ${deployement_type}
    IF    "${deployement_type}" == "large" or "${deployement_type}" == "extra large"
        AdminUIWebUI.Launch the AdminUI page in browser
        AdminUIWebUI.Login To Adminui
        Verify Home Page Is Displayed
        Click Button    System Status
        Click on IQ Multiplex status details in ENIQ DWH
        navigate to IQ Multiplex status details window
        ${count}    Get Element Count    //table[@border="1"]//tr
        Should Be True    ${count}>1
        Navigate to main page
        AdminUIWebUI.Logout from Adminui     
    ELSE
        Log To Console    Its a Single blade server ,hence Multiplex status details will not be present 
    END

TC_11 Verify product name of ENIQ REP database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show status details in ENIQ REP
    Verify Status is displayed    xpath://font[contains(text(),"ENIQ REP")]/parent::td/preceding-sibling::td/img[@alt="Green"]
    Page Should Contain Element    xpath://*/td[contains(text(),'Services Running')]/font[6][@color='green']
    navigate to database status detils window
    ${Product_name}=    Get Text    xpath://td[text()='Product name ']/following-sibling::td
    Log To Console    ${Product_name}
    Dwhmanager.Validate the output    ${Product_name}    	SQL Anywhere
    Navigate to main page
    AdminUIWebUI.Logout from Adminui

TC_12 Check connection information of dwhrep in ENIQ REP database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show connection status details in ENIQ REP
    navigate to DWHREP IQ connection status details window
    Sleep    2s
    ${dwhrep_details}=    Get Text    xpath://td[text()='dwhrep']/following-sibling::td
    Log To Console    ${dwhrep_details}
    Should Not Be Empty    ${dwhrep_details}
    Navigate to main page
    AdminUIWebUI.Logout from Adminui

TC_13 Check partition status as "ACTIVE" using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click on type configuration
    Selecting the techpack
    Selecting the Techlevel
    Sleep    2s
    ${Count}    Get Element Count    //table[@border="1"]//tr[@style]
    Page Should Contain Element    //table[@border="1"]//tr/td[@class="basiclist" and text()]/following-sibling::td[text()='ACTIVE']    limit=${Count}    message=Some elements are not in ACTIVE state
    AdminUIWebUI.Logout from Adminui

TC_14 Activating or inactivating measurement types using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click on type configuration
    Select Techpack
    Select Techlevel
    Sleep    5s
    ${active_status}=    Run Keyword And Return Status    Element Should Contain    //table[@border="1"][1]    INACTIVE
    Log To Console    ${active_status}
    IF    ${active_status} == True
        ${Inactive_Typename}    Get Text    //td[text()='INACTIVE']/preceding-sibling::td[2]
        Sleep    2s
        Click on etlc set history and verify msg
        Click Link    //a[text()='Loader_${Inactive_Typename}']
        Table Should Contain    //table[2]    WARNING    
        Table Should Contain    //table[2]    Set loaded in total 0 rows.
    ELSE
        Log To Console    No inactive status is present
    END
    AdminUIWebUI.Logout from Adminui

TC_15 Check partition plan tables using Adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click on DWH configuration
    Page Should Contain    Time Based Partition    Volume Based Partition
    Sleep    2s
    Page Should Contain Element    //font[contains(text(),"Time Based Partition")]
    Page Should Contain Element    //font[contains(text(),"Volume Based Partition")]
    AdminUIWebUI.Logout from Adminui

TC_16_01 Verifying the Adjusting storage time of partition plan using adminui
    Connect to server as a dcuser
    ${Partition_plan}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click on DWH configuration
    ${Partition_size}=    Get Text    //a[text()="${Partition_plan}_raw"]/following::td[2]
    @{value}=    Get Regexp Matches    ${Partition_size}    \\d+
    ${Partition_size_value}    Convert To Integer    ${value}[0]
    Log To Console    ${Partition_size_value}
    Click Element When Clickable    //a[text()='${Partition_plan}_raw']
    ${Max_storage_text}=    Get Text    //strong[contains(text(),"Maximum storage")]/following::td[1]
    @{Split_max_storage}=    Get Regexp Matches    ${Max_storage_text}    \\d+
    ${Max_storage_value}    Convert To Integer    ${Split_max_storage}[0]
    Log To Console    ${Max_storage_value}
    Click Element When Clickable    //input[@name="defaultStorageTime"]
    ${storage_value}    Get Element Attribute    //input[@name='defaultStorageTime']    value
    Log To Console    ${storage_value}
    ${Techpack_name}    Get Text    //font/b[text()="Tech Pack name"]/following::tr[1]/td[1]/font
    Click on type configuration
    Select From List By Label    //select[@name="type"]    ${Techpack_name}
    Select From List By Label    name:level    RAW
    Click Element When Clickable    //table[@border='1'][1]//tr[4]/td[2]
    ${Row_count}    Get Element Count    //strong[text()="Tablename"]/ancestor::tr[1]/following-sibling::tr
    ${a}=    Evaluate    (${storage_value}/(${Partition_size_value}/24))+1
    ${result} =    Convert To Number    ${a}    0 
    ${result1}=    Convert To Integer    ${result}     
    Log To Console    ${result1}
    Should Be Equal    ${Row_count}    ${result1}
    AdminUIWebUI.Logout from Adminui

TC_16_02 Verifying the Adjusting storage time of partition plan using adminui
    Connect to server as a dcuser
    ${Partition_plan}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Verify Home Page Is Displayed
    Click on DWH configuration
    ${Partition_size}=    Get Text    //a[text()="${Partition_plan}_raw"]/following::td[2]
    @{value}=    Get Regexp Matches    ${Partition_size}    \\d+
    ${Partition_size_value}    Convert To Integer    ${value}[0]
    Log To Console    ${Partition_size_value}
    Click Element When Clickable    //a[text()='${Partition_plan}_raw']
    ${Max_storage_text}=    Get Text    //strong[contains(text(),"Maximum storage")]/following::td[1]
    @{Split_max_storage}=    Get Regexp Matches    ${Max_storage_text}    \\d+
    ${Max_storage_value}    Convert To Integer    ${Split_max_storage}[0]
    Log To Console    ${Max_storage_value}
    ${Storage_Value}=    Get Value    //input[@name="defaultStorageTime"]
    Log To Console    ${Storage_Value}
    ${New_value}    Evaluate    ${Storage_Value} - ${change}
    Log To Console    ${New_value}
    Click Element When Clickable    //input[@name="defaultStorageTime"]
    Clear Element Text    //input[@name="defaultStorageTime"]
    Sleep    3s
    Input Text    //input[@name="defaultStorageTime"]    ${New_value}
    Click Button    //input[@name="submitButton"]
    Sleep    2s
    Page Should Contain    Partition plan ${Partition_plan}_raw saved succesfully. 
    Click Link    //a[text()='${Partition_plan}_raw']
    ${Techpack_name}    Get Text    //font/b[text()="Tech Pack name"]/following::tr[1]/td[1]/font
    Click on type configuration
    Select From List By Label    //select[@name="type"]    ${Techpack_name}
    Select From List By Label    name:level    RAW
    Table Should Contain    //table[5]    ${New_value}
    Click on ETLC Set scheduling
    Select From List By Label    //select[@name="settype"]   Techpack
    Select From List By Label    name:packageSets    ${Techpack_name}
    Click Element    //font[text()="DWHM_StorageTimeUpdate_${Techpack_name}"]/following::td[4]
    Sleep    10s
    Click on type configuration
    Select From List By Label    //select[@name="type"]    ${Techpack_name}
    Select From List By Label    name:level    RAW
    Click Element When Clickable    //td[text()="${New_value}"]/preceding::td[3]
    ${Row_count}    Get Element Count    //strong[text()="Tablename"]/ancestor::tr[1]/following-sibling::tr
    ${a}=    Evaluate    (${New_value}/(${Partition_size_value}/24))+1
    ${result} =    Convert To Number    ${a}    0 
    ${result1}=    Convert To Integer    ${result}     
    Log To Console    ${result1}
    Should Be Equal    ${Row_count}    ${result1}
    AdminUIWebUI.Logout from Adminui

TC_16_03 Revert back to the default storagetime partition plan using adminui
    Connect to server as a dcuser
    ${Partition_plan}=    Execute Command    cat /eniq/installation/config/extra_params/deployment
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login To Adminui
    Click on DWH configuration
    Click Element When Clickable    //a[text()='${Partition_plan}_raw']
    ${Max_storage_text}=    Get Text    //strong[contains(text(),"Maximum storage")]/following::td[1]
    @{Split_max_storage}=    Get Regexp Matches    ${Max_storage_text}    \\d+
    ${Max_storage_value}    Convert To Integer    ${Split_max_storage}[0]
    Log To Console    ${Max_storage_value}  
    Click Element When Clickable    //input[@name="defaultStorageTime"]
    Clear Element Text    //input[@name="defaultStorageTime"]
    Sleep    3s
    Input Text    //input[@name="defaultStorageTime"]    ${Max_storage_value}
    Click Button    //input[@name="submitButton"]
    Sleep    2s
    Page Should Contain    Partition plan ${Partition_plan}_raw saved succesfully. 
    Click Link    //a[text()='${Partition_plan}_raw']
    ${Techpack_name}    Get Text    //font/b[text()="Tech Pack name"]/following::tr[1]/td[1]/font
    Click on ETLC Set scheduling
    Select From List By Label    //select[@name="settype"]   Techpack
    Select From List By Label    name:packageSets    ${Techpack_name}
    Click Element    //font[text()="DWHM_StorageTimeUpdate_${Techpack_name}"]/following::td[4]
    Sleep    10s
    AdminUIWebUI.Logout from Adminui

TC_16 Verify the Check if there are any partition in an inactive state in the CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    AdminUIWebUI.Execute the Command    dos2unix test.bsh
    Connect to dwhrep in CLi
    ${DWH_partition}=    AdminUIWebUI.Execute the Command    Select TABLENAME From DWHPartition Where STATUS != 'ACTIVE'
    Verify the zero rows in CLI    ${DWH_partition}    (0 rows)
    [Teardown]    Test Teardown

TC_19 Verify the check the view to see if the partition is included in the CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    AdminUIWebUI.Execute the Command    dos2unix test.bsh
    Connect to dc username in CLI
    #${DC_Z_Alarm}=    Execute the Command    echo -e "sp_helptext DC_Z_ALARM_INFO_RAW;\ngo\n" | isql -P ${dc_pwd} -U dc -S dwhdb -b    
    Write     sp_helptext DC_Z_ALARM_INFO_RAW
    ${DC_Z_Alarm}=    Read    delay=2s
    Write    Exit
    ${output}=    Read    delay=1s
    Connect to dwhrep in CLi
    Write    select tablename from DWHPartition Where TABLENAME like '%ALARM_INFO%'
    ${Query_2}=    Read    delay=2s
    #${Query_2}=    Execute the Command    echo -e "select tablename from DWHPartition Where TABLENAME like '%ALARM_INFO%';\ngo\n" | dbisql -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui
    Sleep    5s
    ${DC_Z_Alarm_Info}=    Get Regexp Matches    ${Query_2}    DC_Z_ALARM.*\\d
    Log To Console    ${DC_Z_Alarm_Info}
    FOR    ${Dc_Alarm_table}    IN    @{DC_Z_Alarm_Info}
        Log    ${Dc_Alarm_table}
        AdminUIWebUI.Verify the msg    ${DC_Z_Alarm}    ${Dc_Alarm_table}   
        
    END
    [Teardown]    Test Teardown

TC_21 Verify the Check for insanity using CLI
    Connect to server as a dcuser
    ${current_date}=    Get current date in yyyy.mm.dd result_format
    ${grepError_results}=    Execute Command    cat /eniq/log/sw_log/engine/engine-${current_date}.log | grep -i INSANE
    Verify the logs should be Empty    ${grepError_results}
    [Teardown]    Test Teardown

TC_23_to_26 Verify the Check dwhdb stop and engine status when we shut down DWH database using CLI
    Connect to server as a dcuser
    ${dwhdb_stop}=    Execute Command    /eniq/sw/bin/dwhdb stop
    AdminUIWebUI.Verify the msg    ${dwhdb_stop}    Service stopping eniq-dwhdb
    ${dwhdb_status}=    Execute Command    /eniq/sw/bin/dwhdb status
    AdminUIWebUI.Verify the msg    ${dwhdb_status}    dwhdb is not running
    ${engine_status}=    AdminUIWebUI.Execute the Command    engine status
    AdminUIWebUI.Verify the msg    ${engine_status}    Completed successfully
    AdminUIWebUI.Verify the msg    ${engine_status}    engine is running OK
    AdminUIWebUI.Verify the msg    ${engine_status}   lwp helper is running
    Verify the dwhdb stop log

Verify the Check dwhdb status and engine status when we shut down DWH database connection in adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    Login To Adminui with Handle alert
    AdminUIWebUI.Click on button    System Status
    Handle Alert
    Verify the status colour is displayed in webpage    1    red   
    Verify module status is displayed in webpage    ENIQ DWH    Red                   
    Vaildate the database connection error in adminui
    AdminUIWebUI.Click on scroll down button
    AdminUIWebUI.Logout from Adminui
    Close Browser

Verify the Check dwhdb status and engine status when we shut down DWH database in adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    Login To Adminui with Handle alert
    AdminUIWebUI.Click on button    System Status
    Handle Alert
    Verify the status colour is displayed in webpage    1    red
    Verify module status is displayed in webpage    ENIQ DWH    Red     
    Vaildate the counter volume information error
    AdminUIWebUI.Click on scroll down button
    AdminUIWebUI.Logout from Adminui
    Close Browser

Verify the Check dwhdb start and engine status when we shut down DWH database using CLI
    Connect to server as a dcuser
    ${dwhdb_start}=    Execute Command    /eniq/sw/bin/dwhdb start
    AdminUIWebUI.Verify the msg    ${dwhdb_start}    Service enabling eniq-dwhdb
    ${dwhdb_status}=    Execute Command    /eniq/sw/bin/dwhdb status
    AdminUIWebUI.Verify the msg    ${dwhdb_status}    dwhdb is running OK
    ${engine_status}=    AdminUIWebUI.Execute the Command    engine status
    AdminUIWebUI.Verify the msg    ${engine_status}    Completed successfully
    AdminUIWebUI.Verify the msg    ${engine_status}    engine is running OK
    AdminUIWebUI.Verify the msg    ${engine_status}   lwp helper is running
    Verify the dwhdb start log
    

Verify the Check dwhdb status and engine status when we start DWH database in adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    Login To Adminui with Handle alert
    Verify the status colour is displayed in webpage    1    green    
    Verify the status colour is displayed in webpage    6    green    
    Verify the ENIQ DWH status colours in adminui
    Verify the Engine status colours in adminui       
    AdminUIWebUI.Click on scroll down button
    AdminUIWebUI.Logout from Adminui
    [Teardown]    Test teardown

TC_27 Verify the counter volume status when we start DWH database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login to Adminui
    Verify the Adminui Homepage is displayed
    AdminUIWebUI.Click on button    System Status
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    Click Link    Counter Volume Information
    Verify the counter volume information in Adminui
    Click on scroll down
    AdminUIWebUI.Logout from Adminui
    [Teardown]    Test teardown

TC_28_to_32 Verify the check repdb and engine status when we shut down REP database using CLI
    Connect to server as a dcuser
    ${repdb_stop}=    Execute Command    /eniq/sw/bin/repdb stop 
    AdminUIWebUI.Verify the msg    ${repdb_stop}    Service stopping eniq-repdb
    ${repdb_status}=    Execute Command    /eniq/sw/bin/repdb status
    AdminUIWebUI.Verify the msg    ${repdb_status}    repdb is not running
    ${engine_status}=    AdminUIWebUI.Execute the command    engine status
    AdminUIWebUI.Verify the msg    ${engine_status}    Current Profile: Normal
    AdminUIWebUI.Verify the msg    ${engine_status}    engine is running OK
    AdminUIWebUI.Verify the msg    ${engine_status}   lwp helper is running
    Verify the repdb stop log

Verify the check repdb and engine status when we shut down REP database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login to Adminui
    Verify the Loader status error
    AdminUIWebUI.Logout from Adminui
    Close Browser

Verify the Check engine logs when we shutdown repdb using CLI
    Connect to server as a dcuser
    ${date}    Execute command    date '+%Y_%m_%d'
    AdminUIWebUI.Execute the Command    cd /eniq/log/sw_log/engine
    ${grepError_results}=    AdminUIWebUI.Execute the Command    cat engine-${date}.log | grep -i Error
    AdminUIWebUI.Verify the msg    ${grepError_results}    Error 
    
    
    

Verify the Check repdb and engine status when we start REP database using CLI
    ${repdb_status}=    Execute Command     /eniq/sw/bin/repdb start 
    AdminUIWebUI.Verify the msg    ${repdb_status}    Service enabling eniq-repdb
    ${repdb_status}=    Execute Command     /eniq/sw/bin/repdb status
    AdminUIWebUI.Verify the msg    ${repdb_status}    repdb is running OK
    ${engine_status}=    AdminUIWebUI.Execute the command    engine status
    AdminUIWebUI.Verify the msg    ${engine_status}    Current Profile: Normal
    AdminUIWebUI.Verify the msg    ${engine_status}    engine is running OK
    AdminUIWebUI.Verify the msg    ${engine_status}   lwp helper is running
    Verify the repdb start log

Verify the Check repdb and engine status when we start REP database using adminui
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login to Adminui
    Verify the status colour is displayed in webpage    6    green        
    Verify the status colour is displayed in webpage    2    green        
    Verify module status is displayed in webpage    Engine    Green    
    Click on Engine Status link
    Switch window to new Engine status details tab
    AdminUIWebUI.Click on scroll down button
    Verify the engine service in AdminUI page
    AdminUIWebUI.Switch window to back to Adminui tab
    AdminUIWebUI.Click on scroll down button
    AdminUIWebUI.Logout from Adminui
    Close Browser
    [Teardown]    Test teardown



*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
Test Teardown
    Close All Connections
    Capture Page Screenshot
    Close Browser
    ${dwhdb_return_status}=    Run Keyword And Return Status    Verify the dwhdb status    
    IF    ${dwhdb_return_status} == True
        Log To Console    dwhdb is running OK    
    ELSE
        ${dwhdb_start}=    Execute Command    /eniq/sw/bin/dwhdb start
    END

    ${repdb_return_status}=    Run Keyword And Return Status    Verify the repdb status    
    IF    ${repdb_return_status} == True
        Log To Console    repdb is running OK    
    ELSE
        ${repdb_status}=    Execute Command     /eniq/sw/bin/repdb start
    END

