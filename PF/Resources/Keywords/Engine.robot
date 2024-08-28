*** Settings ***
Library    SSHLibrary
Library    DateTime
Library    String
Library    Collections
Library    RPA.Browser.Selenium
Library    OperatingSystem
	
*** Keywords ***
Go to the folder
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=2s
    Log     ${output}
    [Return]    ${output}

Executing the command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read Until Prompt
    Log     ${output}
    [Return]    ${output}
    
Execute the Command
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=3s
    Log     ${output}
    [Return]    ${output}

Execute the Commands
    [Arguments]    ${command}
    Write    ${command}
    ${output}=    Read    delay=10s
    Log     ${output}
    [Return]    ${output}

Validate the output
    [Arguments]    ${output}    ${validate_msg}    
    Log    ${output}
    Should Contain    ${output}   ${validate_msg}

Validate the log file for
    [Arguments]   ${msg_to_grep}    ${user_file}    ${flag}
    ${msg_count}=    Write    grep -irc '${msg_to_grep}' ${user_file}
    #Log    ${msg_count}
    Read    delay=1s
    Log    ${msg_count}
    Should Contain    ${msg_count}    ${flag}
    IF    ${flag} == 0
        Should Contain    ${msg_count}    0
    ELSE        
        Write    grep -ir '${msg_to_grep}' ${user_file}
        Read    delay=2s
        
    END
    [Return]    ${msg_count}    

    
Verify the log file containing
    [Arguments]    ${output_content}    @{logfile_content}
    Log    ${output_content}
    Should Contain Any   ${output_content}    @{logfile_content}

Get latest file from directory
    [Arguments]    ${latestfile}
    Write    ls -Art ${latestfile} | tail -n 1
    ${output}=    Read    delay=2s
    Log    ${output}
    [Return]    ${output}


Get current date in dd.mm.yyyy result_format
    ${currentdatefmt} =    Get Current Date    result_format=%b %d, %Y
    Log    ${currentdatefmt}
    [Return]    ${currentdatefmt}

Get Expiration date    
    [Arguments]    ${expire_date_str}
    ${expire_date_1}=    Split To Lines    ${expire_date_str}
    ${expire_date_day}=    Split String    ${expire_date_1}[-3]    :
    ${stripped_date}=    Strip String    ${expire_date_day}[1]    mode=left
    ${expire_1}=    Convert Date    ${stripped_date}    date_format=%b %d, %Y %H      result_format=%b %d, %Y
    Log    ${expire_1}
    [Return]    ${expire_1}
      
Verify the engine service in AdminUI page
    Sleep    2s
    Page Should Contain    Status: active
    Page Should Contain    cache status : initialized
    Page Should Contain    Current Profile: Normal
    
Click on Engine Status link
    RPA.Browser.Selenium.Click Link    xpath://*[@href='EngineStatusDetails']
    Sleep    3s

Switch window to new Engine status details tab
    Switch Window    new

Verify license expire date
    [Arguments]    ${cmd_output}
    ${currentDate}=    Get current date in dd.mm.yyyy result_format
    ${expireDate}=    Get Expiration date    ${cmd_output}
    ${previousDay}=    Subtract Time From Date    ${currentDate}    1day    result_format=%b %d, %Y    date_format=%b %d, %Y
    Run Keyword If    '${expireDate}' == '${previousDay}'    Fail    License Getting Expire Tomorrow
    ${licenseDate}=    Subtract Date From Date    ${expireDate}    ${currentDate}    date1_format=%b %d, %Y    date2_format=%b %d, %Y
    Run Keyword If    ${licenseDate} < 0    Fail    LicenseExpired
      

Verify the Active Interfaces for multiple ENM connections
    [Arguments]    @{array_enm}
    FOR   ${eniq_oss_enm}   IN    @{array_enm}
        Write    engine -e showActiveInterfaces | grep -i ${eniq_oss_enm}
        ${output1}=    Read    delay=5s
        Should Contain    ${output1}    eniq_oss
        Should Contain    ${output1}    INTF
        
    END
    
Verify 'Getting Active Interfaces' is displayed
    [Arguments]    ${txt}
    Should Contain   ${txt}    Getting active interface

Get the number of ENM Connections
    Go to the folder    cd /eniq/sw/conf
    ${output}=    Execute the command    cat .oss_ref_name_file  
    @{array_1}=    Split To Lines    ${output}
    ${list_enm_conn}=    Set Variable
    ${flag}=    Set Variable    false
    @{list_enm_conn}    Create List
    FOR    ${enm_no}    IN    @{array_1}
        ${result_1}    ${result_2}    Run Keyword And Ignore Error    Should Contain    ${enm_no}    eniq_oss
        IF    '${result_1}' == 'PASS'
            ${flag}=    Set Variable    true
            ${enm_1}=    Get Substring    ${enm_no}    0    end=11
            Append To List    ${list_enm_conn}    ${enm_1}
        END
    END

    Run Keyword If    '${flag}' == 'false'    Fail    ENMConnections Not Found 
    Log   List of ENM Connections ${list_enm_conn} 
    [Return]    @{list_enm_conn}

Verify Active Interface is listed
  Go to the folder    ${installer path}
  ${cmd_output}=    Execute the command  ./get_active_interfaces  
  Should Contain    ${cmd_output}    INTF

Verification of disable Sets
    [Arguments]    ${disable_output}    ${disable_msg}
    Should Contain    ${disable_output}    ${disable_msg}

Verification of enable Sets
    [Arguments]    ${Enable_output}    ${Enable_msg}
    Log    ${Enable_output}
    Should Contain    ${Enable_output}    ${Enable_msg} 

Verify the msg
    [Arguments]    ${Engine_output}    ${success_msg}
    Log    ${Engine_output}
    Should Contain    ${Engine_output}    ${success_msg}

Verify the error msg
    [Arguments]    ${Error_output}    ${Error_msg}
    Log    ${Error_output}
    Should Contain    ${Error_output}    ${Error_msg}

Verify the engine e-status
    [Arguments]    ${Status_output}    ${status_msg}
    Should Contain    ${Status_output}    ${status_msg}   

verify for no errors in logs 
    [Arguments]   ${output}
    Should Contain    ${output}    0
    #Just to make sure it shouldnot contain any timestamp format in output
    #Should Not Contain    ${output}    0.
    Should Not Contain    ${output}    .0
    Should Not Contain    ${output}    :0
    Should Not Contain    ${output}    0:
    
Grep message from file
    [Arguments]   ${msg_to_grep}    ${user_file}    
    ${msg_count}=    Write    grep -irc '${msg_to_grep}' ${user_file}
    Log    ${msg_count}
    ${grepResults}=    Read    delay=1s
    Log    ${grepResults}
    [Return]    ${grepResults}

Launch the AdminUI page in browser
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${Login_AdminUI_URL}
    Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
    RPA.Browser.Selenium.Maximize Browser Window
    RPA.Browser.Selenium.Set Selenium Speed    ${DELAY}
    # RPA.Browser.Selenium.Click Button  id:details-button
    # RPA.Browser.Selenium.Click Link    id:proceed-link
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window
    Wait For Elements
    
Wait For Elements
    RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@id='username'] 
    RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@id='password'] 
    RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@type='submit']

Login To Adminui
    Wait For Elements
    Input Username    ${USERNAME}
    Input Pass    ${PASSWORD}
    Click On Submit Button
	Sleep    5s
    RPA.Browser.Selenium.Wait Until Page Contains    System Monitoring
    
Verify the System Status page displayed
    Page Should Contain    DATABASE
    
Verify the ETLC Monitoring page displayed
    Page Should Contain    Running ETL Sets
    
Click on link
    [Arguments]    ${link_name}
    Click Link    ${link_name}
    Sleep    3s
    
Verify the remove techpack in adminui page
    [Arguments]    ${techpack}
    Page Should Not Contain    ${techpack}
    
Logout from Adminui
    RPA.Browser.Selenium.Click Link    link:Logout
    RPA.Browser.Selenium.Page Should Contain    You have logged out.
    Capture page screenshot
    
Input Username
    [Arguments]    ${USERNAME}
    RPA.Browser.Selenium.Input Text    id:username    ${USERNAME}

Input Pass
    [Arguments]    ${PASSWORD}
    RPA.Browser.Selenium.Input Text    id:password    ${PASSWORD}
	
Click On Submit Button
    RPA.Browser.Selenium.Click Button    xpath://*[@type='submit']

Switch window to back to Adminui tab
    Switch Window    main

Click on scroll down button
    Execute Javascript    window.scrollTo(0,2000)
    Sleep    2s
    
Click on scroll up button
    Execute Javascript    window.scrollTo(0,0)
    Sleep    2s

Running the script
    [Arguments]    ${command}
    Set Client Configuration    prompt=[eniq_stats] {dcuser} #:    timeout=900
    Write    ${command}
    ${output}=    Read Until Prompt
    Log     ${output}
    [Return]    ${output}

Remove log file
    Execute the Command    rm install_lockfile

Executing password change script and providing complaint random generated
    ${random_password_generated}=    random_complaint_password
    Log To Console    ${random_password_generated}
    Execute the Command    passwd
    Execute the Command    ${random_password_generated}
    Execute the Command    ${random_password_generated}
    ${output_of_executed_script}=    Read    delay=10s
    [Return]    ${output_of_executed_script} 

Get current date in yyyy.mm.dd result_format
    ${currentdatefmt} =    Get Current Date    result_format=%Y %b %d,
    Log    ${currentdatefmt}
    [Return]    ${currentdatefmt}

Verify module status is displayed in webpage
    [Arguments]    ${module_name_args}    ${module_status_args}
    Page Should Contain element    xpath://font[contains(text(),"${module_name_args}")]/parent::td/preceding-sibling::td/img[@alt="${module_status_args}"]
    Sleep    1s

Verify the status colour is displayed in webpage
    [Arguments]    ${font}    ${colour} 
    Page Should Contain element    xpath://*/td[contains(text(),'Services Running')]/font[${font}][@color='${colour}']
    Sleep    1s

Vaildate the database connection error in adminui
    Page Should Contain    Failed to initialise database connection to 'ENIQ DWH'

Click on button
    [Arguments]    ${continue_name}
    RPA.BROWSER.Selenium.Click button    ${continue_name}
    Sleep    2s

Vaildate the counter volume information error 
    Page Should Contain    Unable to retrieve counter volume information.
    RPA.Browser.Selenium.Capture page screenshot

Verify the Loader status error
    Page Should Contain    LoaderStatus.doHandleRequest failed due to exception: Failed to get current user entries  
    RPA.Browser.Selenium.Capture page screenshot

Verify the zero rows in CLI
    [Arguments]    ${output}    ${Zero_rows}
    Log    ${output}
    Should Contain    ${output}    ${Zero_rows}

Verify the rows in CLI
    [Arguments]    ${output}    ${rows}
    Log    ${output}
    Should Contain    ${output}    ${rows}

Verify the dwhdb start log
    ${date}    Execute command    date "+%y%m%d_%H"
    ${dwhdb_file}=    Execute Command    cd /eniq/log/sw_log/iq/dwhdb && ls | grep start_dwhdb.${date} | tail -1
    ${output}     ${rc}=    Execute Command    cd /eniq/log/sw_log/iq/dwhdb && grep -i -E 'exception|error' ./${dwhdb_file}    return_rc=True
    ${output_length}    Get Length    ${output}
    Log To Console    ${output_length}
    IF    '${rc}' == '1' and '${output_length}' == '0'
        Log To Console    "Database dwhdb succesfully started"
    ELSE
        Fail    ${output}   
    END

Verify the dwhdb stop log
    ${date}    Execute command    date "+%y%m%d_%H"
    ${dwhdb_file}=    Execute Command    cd /eniq/log/sw_log/iq/dwhdb && ls | grep stop_dwhdb.${date} | tail -1
    ${output}     ${rc}=    Execute Command    cd /eniq/log/sw_log/iq/dwhdb && grep -i -E 'exception|error' ./${dwhdb_file}    return_rc=True
    ${output_length}    Get Length    ${output}
    Log To Console    ${output_length}
    IF    '${rc}' == '1' and '${output_length}' == '0'
        Log To Console    "Database is down"
    ELSE
        Fail    ${output}   
    END

Verify the logs should be Empty
    [Arguments]    ${logs_empty}
    Should Be Empty    ${logs_empty}

Login To Adminui with Handle alert
    Wait For Elements
    Input Username    ${USERNAME}
    Input Pass    ${PASSWORD}
    Click On Submit Button
	Sleep    5s
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE

Verify the repdb stop log    
    ${date}    Execute command    date "+%y%m%d_%H"
    ${scheduler_file}=    Execute Command    cd /eniq/log/sw_log/asa/ && ls | grep stop_repdb_${date} | tail -1
    ${output}     ${rc}=    Execute Command    cd /eniq/log/sw_log/asa/ && grep -i -E 'exception|error' ./${scheduler_file}    return_rc=True
    ${output_length}    Get Length    ${output}
    Log To Console    ${output_length}
    IF    '${rc}' == '1' and '${output_length}' == '0'
        Log To Console    "Database is down"
    ELSE
        Fail    ${output}   
    END

Verify the repdb start log
    ${date}    Execute command    date "+%y%m%d_%H"
    ${scheduler_file}=    Execute Command    cd /eniq/log/sw_log/asa/ && ls | grep start_repdb_${date} | tail -1
    ${output}     ${rc}=    Execute Command    cd /eniq/log/sw_log/asa/ && grep -i -E 'exception|error' ./${scheduler_file}    return_rc=True
    ${output_length}    Get Length    ${output}
    Log To Console    ${output_length}
    IF    '${rc}' == '1' and '${output_length}' == '0'
        Log To Console    "Database repdb successfully started"
    ELSE
        Fail    ${output}   
    END

Verify the dwhdb status
    ${teardown_dwhdb_status}=    Execute Command    /eniq/sw/bin/dwhdb status
    Verify the msg    ${teardown_dwhdb_status}    dwhdb is running OK

Verify the repdb status
    ${teardown_repdb_status}=    Execute Command     /eniq/sw/bin/repdb status
    Verify the msg    ${teardown_repdb_status}    repdb is running OK

Verify eniq_oss_2 is present
    ${active_interfaces}=    Execute Command    cd /eniq/sw/installer ; ./get_active_interfaces | grep -i eniq_oss_2
    Verify the msg    ${active_interfaces}    eniq_oss_2

Verify the ENIQ DWH status colours in adminui
    ${No_techpack_installtion}=    Run Keyword And Return Status    Verify module status is displayed in webpage    ENIQ DWH    Green                
    IF    ${No_techpack_installtion} == True
        Log    ENIQ DWH                             
    ELSE
        Verify module status is displayed in webpage    ENIQ DWH    Yellow    
    END

Verify the Engine status colours in adminui
    ${No_techpack_installtion}=    Run Keyword And Return Status    Verify module status is displayed in webpage    Engine    Green                
    IF    ${No_techpack_installtion} == True
        Log    Engine                            
    ELSE
        Verify module status is displayed in webpage    Engine    Yellow    
    END

Grant permission
    [Arguments]    ${yes_or_no}
    Write    ${yes_or_no}




    


    
