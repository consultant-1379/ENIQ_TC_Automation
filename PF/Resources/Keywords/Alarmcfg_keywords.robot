*** Settings ***
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Library    Collections
Library    String
	
*** Keywords ***

Set time delay
    RPA.Browser.Selenium.Set Selenium Speed    1 second

# Launch the Alarmcfg webpage
#     [Arguments]    ${login_url_args}
    # Set time delay
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${login_url_args}
    # RPA.Browser.Selenium.Maximize Browser Window
    # RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@value='Login']    timeout=40
    # Sleep    2s
    # RPA.Browser.Selenium.Capture page screenshot


Launch the Alarmcfg webpage
    [Arguments]    ${login_url_args}
    Set time delay
    Open Available Browser    ${login_url_args}    options=set_capability("acceptInsecureCerts", True)
    # Open Available Browser    ${login_url_args}    options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window

Launch the Alarmcfg webpage in browser
    Launch the Alarmcfg webpage    ${login_almcfg_url}

Launch the Alarmcfg webpage with ip address in browser 
    Launch the Alarmcfg webpage    ${login_almcfg_ip}

Input Alarmcfg Login Details
    [Arguments]    ${system_args}    ${username_args}    ${password_args}    ${auth_args} 
    Set time delay
    RPA.Browser.Selenium.Input Text    name:cms    ${system_args}
    RPA.Browser.Selenium.Input Text    name:username    ${username_args} 
    RPA.Browser.Selenium.Input Text    name:password    ${password_args}
    RPA.Browser.Selenium.Select From List By Label    name:authtype    ${auth_args}
       
Click Login Button
    RPA.Browser.Selenium.Click Button     xpath://*[@value='Login']
    Capture Page Screenshot
    Sleep    2s

Logout Alarmcfg webpage
    RPA.Browser.Selenium.Click Link    Logout
    RPA.Browser.Selenium.Wait Until Page Contains Element    xpath://*[@value='Login']    timeout=40
    # RPA.Browser.Selenium.Capture page screenshot

Verify Alarmcfg webpage is displayed
    RPA.Browser.Selenium.Page Should Contain   Alarm Configuration  

Verify Login with valid credentials
    RPA.Browser.Selenium.Wait Until Page Contains   Logout    timeout=40
    RPA.Browser.Selenium.Page Should Contain    Interfaces
    RPA.Browser.Selenium.Capture page screenshot

Verify Homepage is not displayed 
    Wait Until Element Is Visible   xpath://div[@class='error']    timeout=40 
    RPA.Browser.Selenium.Page Should Contain    Could not log in

Verify the All Subcategories links in Alarmcfg Homepage is displayed
    Log To Console    Subcategories list in Alarmcfg Homepage: ${almcfg_time_list}
    FOR    ${almcfg_time}    IN    @{almcfg_time_list}
        RPA.Browser.Selenium.Page Should Contain Link    ${almcfg_time}     
    END

Launch the Alarmcfg webpage in Firefox browser    
    [Arguments]    ${login_url_args}
    # Open Available Browser    ${login_url_args}    options=add_argument("--ignore-certificate-errors")    browser_selection=Firefox,Chrome
    Open Available Browser    ${login_url_args}    options=set_capability("acceptInsecureCerts", True)    browser_selection=Firefox,Chrome
    Maximize Browser Window
    # ${firefox_options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()      sys
    # Call Method    ${firefox_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Firefox    executable_path=${EXEC_DIR}/PF/Resources/Drivers/geckodriver.exe     
    # RPA.Browser.Selenium.Go To    ${login_url_args}
    # RPA.Browser.Selenium.Maximize Browser Window
    # RPA.Browser.Selenium.Wait Until Element Is Visible    xpath://*[@value='Login']    timeout=40
    # Sleep    2s
    # RPA.Browser.Selenium.Capture page screenshot
    
Launch webpage with invalid port
    [Arguments]    ${login_webpage_args}
    ${status}    Run Keyword And Return Status    Open Available Browser    ${login_webpage_args}    browser_selection=Chrome      
    IF    ${status}
        Fail    Site is reachable
    ELSE
        Log   Site can't be reached due to invalid port
    END 
    Sleep    5s

Verify message is displayed
    [Arguments]    ${text_message}
    Page Should Contain    ${text_message}  

Launch Alarmcfg url with invalid port
    Launch webpage with invalid port   ${login_almcfg_invalid_port}

Launch Alarmcfg ip address with invalid port
    Launch webpage with invalid port   ${login_almcfg_ip_invalid_port}

Set wait time for keywords
    Set Selenium Implicit Wait    20s

Click Interface link
    [Arguments]    ${interface_link_args}
    Set wait time for keywords
    Click Link    ${interface_link_args}
    # Element Should Contain    id:action_title    ${interface_link_args}
    Capture Page Screenshot  

Verify change alarm password script is not executed 
    [Arguments]    ${error_output_args}    ${error_msg_args}     
    Should Contain    ${error_output_args}    ${error_msg_args}
    Sleep    2s

Verify Add report Button is visible
    Page Should Contain Element    xpath://input[@value="Add Report"]

Verify Interface page is displayed
    [Arguments]    ${interface_element_args}
    Element Should Contain    id:action_title    ${interface_element_args}

Verify Alarmcfg webpage logged out
    RPA.Browser.Selenium.Page Should Contain Element   xpath://*[@value='Login']

Verify All Alarms Interface page is displayed
    ${check_no_report_table}=    Run Keyword And Return Status    Element Should Contain    id:action_title    No reports for All interface
    IF    ${check_no_report_table} == True
        Log    No reports for All interface
    ELSE
        Page Should Contain Element    id:report_table
    END

Opening the AlarmInterface latest file and checking for failure
    [Arguments]    ${latest_files}
     ${engine_logs}=    Execute Command    cat ${Alarm_folder}${latest_files}|grep -i 'ALARM DATA SENDING FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed'
    Log To Console    ${engine_logs}
    [Return]    ${engine_logs}

verify logs should not contain faliure
    [Arguments]    ${failure_logs}
    Should Be Empty    ${failure_logs}

Opening the Alarm latest file and checking for Success message
    [Arguments]    ${latest_files}
    ${engine_logs}=    Execute Command    cat ${Alarm_folder}${latest_files}|grep -i 'ALARM DATA SENT'
    Log To Console    ${engine_logs}
    [Return]    ${engine_logs}

Opening the loader_DC_Z_ALARM latest file and checking for failure message
    [Arguments]    ${latest_files}
    ${failure_DC_Z_log}=    Execute Command    cat ${DC_Z_Log_path}${latest_files}|grep -i '\\bnot loaded\\b\\|\\bEXCEPTION\\b\\|\\bsevere\\b\\|\\bnot found\\b\\|\\bfailed\\b\\|\\bError\\b'| grep -v "Adapter_AlarmInterface_RD"
    #${failure_DC_Z_log}=    Execute Command    cat /eniq/log/sw_log/engine/DC_Z_ALARM/engine-2024_04_09.log|grep -i '\\bnot loaded\\b\\|\\bEXCEPTION\\b\\|\\bsevere\\b\\|\\bnot found\\b\\|\\bfailed\\b\\|\\bError\\b' | grep -v "Adapter_AlarmInterface_RD"
    Log To Console    ${failure_DC_Z_log}
    [Return]    ${failure_DC_Z_log}

verify logs should contain success message
    [Arguments]    ${check_success_message}
    Should Not Be Empty    ${check_success_message}

Executing change password script and providing noncomplaint random genrated password
    ${random_password_generated}=    random_noncomplaint_password
    Log To Console    ${random_password_generated}
    Write    cd /eniq/sw/bin
    Write    ./change_alarm_password.bsh
    Write    ${random_password_generated}
    ${output_of_executed_script}=    Read    delay=10s
    [Return]    ${output_of_executed_script}   

Verify password is not changed
    [Arguments]    ${output_of_scripts}
    Should Not Contain    ${output_of_scripts}    Alarm password changed successfully

Executing password change script and providing complaint random generated password
    ${random_password_generated}=    random_complaint_password
    Log To Console    ${random_password_generated}
    Write    cd /eniq/sw/bin
    Write    ./change_alarm_password.bsh
    Write    ${random_password_generated}
    ${output_of_executed_script}=    Read    delay=10s
    [Return]    ${output_of_executed_script}   

Verify password is changed 
    [Arguments]    ${reading_output_of_executed_script}
    ${checking_if_password_is_changed}=    Run Keyword And Return Status   Should Contain    ${reading_output_of_executed_script}    Alarm password changed successfully
    [Return]    ${checking_if_password_is_changed}

changing password to old password 
    [Arguments]    ${New_password_present}
    IF    "${New_password_present}"=="True"  
        
        Write    cd /eniq/sw/bin
        Write    ./change_alarm_password.bsh
        Write    ${Alarm_password}
        Log To Console    Password is changed to Old password
    ELSE
        FAIL    Alarm password not changed
    END
    
listing all files in path and search for common text jar
    [Arguments]    ${file_path_args}
    ${list_of_common_texts_jar_file}=    Execute Command    ls ${file_path_args}|grep -i 'commons-text'
    Log To Console    ${list_of_common_texts_jar_file}
    [Return]    ${list_of_common_texts_jar_file}

Verify if common text file exist in file path
    [Arguments]    ${verify_common_text_exist}
     Should Be Empty    ${verify_common_text_exist}

Getting latest file from the folder
    [Arguments]    ${folder_name}    ${file_name}
    ${getting_latest_file}=    Execute Command    ls ${folder_name}|grep ${file_name}|tail -1
    Log To Console    ${getting_latest_file}
    [Return]    ${getting_latest_file}

Opening the AlarmCfg latest file and searching for failure
    [Arguments]    ${latest_file}
    ${AlarmCfg_error_log}=    Execute Command    cat ${AlarmCfg_folder}${latest_file}|grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\|Error'
    Log To Console    ${AlarmCfg_error_log}
    [Return]    ${AlarmCfg_error_log}

Opening the AlarmInterface latest file and checking for failure message
    [Arguments]    ${latest_files}
    ${failure_AlarmInterface_log}=    Execute Command    cat ${alarm_interface_path}/${latest_files}| grep -i 'not loaded\\|FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\|Error'
    Log To Console    ${failure_AlarmInterface_log}
    [Return]    ${failure_AlarmInterface_log}

Click Add report button
    Set wait time for keywords
    Click Button    xpath://input[@value="Add Report"]
    Capture Page Screenshot
    Sleep    2s
    
Select alarm template from available reports
    [Arguments]    ${alm_template_args}
    # Click Link    xpath://td[text()="${alm_template_args}"]//preceding-sibling::td/a
    Set Selenium Page Load Timeout    600s
    Wait Until Keyword Succeeds    2x    5s    Click Link    xpath://td[text()="${alm_template_args}"]//preceding-sibling::td/a
    Wait Until Page Contains Element    id:add_alarm_button    timeout=50s
    Capture Page Screenshot

Select node data from dropdown list
    [Arguments]    ${dropdown_data_xpath}    ${intf_basetable_args} 
    Set time delay
    ${dropdown_data}=    Get Text    ${dropdown_data_xpath}
    @{dropdown_data_list}=    Split To Lines    ${dropdown_data}
    Log   ${dropdown_data_list}
    Should Not Be Empty    ${dropdown_data_list}
    FOR   ${dropdown_var}  IN   @{dropdown_data_list}
        ${intf_str}=    Run Keyword And Return Status    Should Contain    ${intf_basetable_args}    ${dropdown_var}
        IF  ${intf_str}==True
            Log To Console    ${dropdown_var}
            Select From List By Label     ${dropdown_data_xpath}    ${dropdown_var}
            Exit For Loop
        END
    END
    Run Keyword If    ${intf_str}==False    Skip    list does not contain specified node
    Capture Page Screenshot
    Sleep    2s
    
Select basetable from dropdown list
    [Arguments]   ${intf_basetable_args} 
    Select node data from dropdown list    select_techpacks    ${intf_basetable_args}    
    Select node data from dropdown list    select_types    ${intf_basetable_args}    
    Select node data from dropdown list    select_levels    ${intf_basetable_args}    
    Select node data from dropdown list    select_basetables    ${intf_basetable_args}    

Click Add alarm report button
    Wait Until Keyword Succeeds    3x    5s    Click Button    id:add_alarm_button
    Wait Until Page Contains Element   xpath://input[@value="Add Report"]    timeout=50s
    Capture Page Screenshot
    Sleep    2s

Count alarm report table rows
    ${count_rows}=    Get Element Count    xpath://table[@id="report_table"]/tbody/tr
    [Return]    ${count_rows}

# Verify alarm report addition
#     [Arguments]    ${intf_basetable_args}    ${alm_template_args}
#     ${rows_count}=    Count alarm report table rows
#     ${alm_report_status}=    Run Keyword And Return Status    Page Should Contain Element    xpath://tr[${rows_count}][td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]   
#     [Return]     ${alm_report_status}
#     Sleep    2s
    
# Disable Alarm report
#     [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}  
#     Set time delay      
#     Click Interface link     ${interface_link_args}    
#     ${rows_count}=    Count alarm report table rows
#     Click Element    xpath://tr[${rows_count}][td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Disable"]
#     Capture Page Screenshot
#     Sleep    2s

# Enable Alarm report
#     [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}
#     Set time delay 
#     Click Interface link    ${interface_link_args}
#     ${rows_count}=    Count alarm report table rows
#     Click Element    xpath://tr[${rows_count}][td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Enable"]
#     Capture Page Screenshot
#     Sleep    2s

# Delete Alarm report
#     [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}
#     Set time delay 
#     Click Interface link    ${interface_link_args} 
#     ${rows_count}=    Count alarm report table rows
#     Click Element    xpath://tr[${rows_count}][td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Remove"]
#     Handle Alert    timeout=10s   
#     Capture Page Screenshot
#     Sleep    2s

Verify alarm report addition
    [Arguments]    ${intf_basetable_args}    ${alm_template_args}
    ${rows_count}=    Count alarm report table rows
    ${alm_report_status}=    Run Keyword And Return Status    Page Should Contain Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]   
    [Return]     ${alm_report_status}
    Sleep    2s
    
Disable Alarm report
    [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}  
    Set time delay      
    Click Interface link     ${interface_link_args}    
    ${rows_count}=    Count alarm report table rows
    Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Disable"]
    Capture Page Screenshot
    Sleep    2s

Enable Alarm report
    [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}
    Set time delay 
    Click Interface link    ${interface_link_args}
    ${rows_count}=    Count alarm report table rows
    Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Enable"]
    Capture Page Screenshot
    Sleep    2s

Delete Alarm report
    [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}
    Set time delay 
    Click Interface link    ${interface_link_args} 
    ${rows_count}=    Count alarm report table rows
    Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Remove"]
    Handle Alert    timeout=10s   
    Capture Page Screenshot
    Sleep    2s


Open clearcasevobs
    # ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    # Log    ${EXEC_DIR}
    # RPA.Browser.Selenium.Create Webdriver    Chrome    executable_path=${EXEC_DIR}/PF/Resources/Drivers/chromedriver.exe    chrome_options=${chrome_options}
    # RPA.Browser.Selenium.Go To    ${clearcase_url}eniqdel
    Open Available Browser    ${clearcase_url}eniqdel
    RPA.Browser.Selenium.Maximize Browser Window
    Sleep    5s
    RPA.Browser.Selenium.Maximize Browser Window 
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html

Getting the latest module and Rstate of alarm from clearcase page	
	${temp}=    Get Element Attribute    //table//a[text()='${alarm_module}']    href
    Set Global Variable    ${temp}
    ${alarm_name}=    Fetch From Right    ${temp}    /
    Log To Console    ${alarm_name}
    ${alarm_names}    Split String From Right    ${alarm_name}    .    
    Log To Console    ${alarm_name}
    ${alarm_name}    Replace String    ${alarm_names}[0]    _R    -R
    Log To Console    ${alarm_name}
    Set Global Variable    ${alarm_name}
    ${alarm_name1}    Replace String    ${alarm_names}[0]    _R    =R   
    Set Global Variable    ${alarm_name1} 
    Log To Console    ${alarm_name1}
    ${rstate}    Get Text    //table//a[text()='${alarm_module}']/../following-sibling::td[3]
    Log To Console    ${rstate}
    Set Global Variable    ${rstate}
    ${product_number}    Get Text    //table//a[text()='${alarm_module}']/../following-sibling::td[2]
    Log To Console    ${product_number}
    ${prod_label}    Set Variable    ${product_number}-${rstate}
    Log To Console    ${prod_label}
    Set Global Variable    ${prod_label}
	
Getting the latest module and Rstate of alarm from Server
	${version_prop}    ${rc}    Execute Command    cat /eniq/sw/platform/${alarm_name}/install/version.properties | grep -i '${prod_label}'    return_rc=True
    set global Variable    $rc
	
Verifying if latest alarm module is already installed on server
	Skip If    $rc==0    ${\n}Skipping the downloading since latest ${alarm_module} is already present in the server.
	
Downloading latest alarm module if not installed on server
	Execute Command    cd /eniq/sw/installer ; wget -nc ${temp}
	
Installing latest alarm module if not installed on server
	${zip_name}    Split String From Right    ${temp}    /
    Execute Command    cd /eniq/sw/installer ; chmod u+x ${zip_name}[-1] 
    ${output}    Execute Command    cd /eniq/sw/installer ; ./platform_installer ${zip_name}[-1] 
    ${failed}    Evaluate    'failed' in '''${output}'''    
    IF    ${failed}
        Fail    *HTML* <span style="color:red"><b>${alarm_module} installation Failed.</b></span>${\n}${output}
    ELSE
        Log    <span style="color:green"><b>${alarm_module} installed Successfully.${\n}Proceeding with log verification.</b></span>    html=True
    END
	
Verifying if latest alarm module got installed on server
	${out}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i ${alarm_module}=
    ${latest}    Evaluate    '${rstate}' in '''${out}'''
    IF    ${latest}
        Log    <span style="color:green"><b>Latest ${alarm_module} rstate is present in versiondb.properties file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>${alarm_module} latest rstate not matching in versiondb.properties file.</b></span>${\n}${out}
    END
	
Verifying if latest alarm module is present on adminUI page.
	Select From List By Label    //select[@name="command"]    Installed modules
    Click Button    Start
    Element should Contain    //input[@value='Start']/following::table[1]//td    ${alarm_name1}   

Getting latest alarm log file and verifying no error should be there
	${zip_name}    Split String From Right    ${temp}    /
    ${out}    ${rc}    Execute Command   cd /eniq/log/sw_log/platform_installer; filename=$(ls -Art ${zip_name}[-1]*.log | tail -n 1); cat $filename | grep -i "warning\|exception\|severe\|not found\|error"    return_rc=True
    IF    ${rc} == 1
        Log    <span style="color:green"><b>No negative keywords are found in ${zip_name}[-1].log file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>Negative keywords found in ${zip_name}[-1].log file.</b></span>${\n}${out}
    END

Getting the latest module and Rstate of alarmcfg from clearcase page	
	${temp}=    Get Element Attribute    //table//a[text()='${alarmcfg_module}']    href
    Set Global Variable    ${temp}
    ${alarmcfg_name}=    Fetch From Right    ${temp}    /
    Log To Console    ${alarmcfg_name}
    ${alarmcfg_names}    Split String From Right    ${alarmcfg_name}    .    
    Log To Console    ${alarmcfg_name}
    ${alarmcfg_name}    Replace String    ${alarmcfg_names}[0]    _R    -R
    Log To Console    ${alarmcfg_name}
    Set Global Variable    ${alarmcfg_name}
    ${alarmcfg_name1}    Replace String    ${alarmcfg_names}[0]    _R    =R   
    Set Global Variable    ${alarmcfg_name1} 
    Log To Console    ${alarmcfg_name1}
    ${rstate}    Get Text    //table//a[text()='${alarmcfg_module}']/../following-sibling::td[3]
    Log To Console    ${rstate}
    Set Global Variable    ${rstate}
    ${product_number}    Get Text    //table//a[text()='${alarmcfg_module}']/../following-sibling::td[2]
    Log To Console    ${product_number}
    ${prod_label}    Set Variable    ${product_number}-${rstate}
    Log To Console    ${prod_label}
    Set Global Variable    ${prod_label}
	
Getting the latest module and Rstate of alarmcfg from Server
	${version_prop}    ${rc}    Execute Command     cat /eniq/sw/installer/versiondb.properties | grep -i ${alarmcfg_name1}    return_rc=True
    set global Variable    $rc
	
Verifying if latest alarmcfg module is already installed on server
	Skip If    $rc==0    ${\n}Skipping the downloading since latest ${alarmcfg_module} is already present in the server.
	
Downloading latest alarmcfg module if not installed on server
	Execute Command    cd /eniq/sw/installer ; wget -nc ${temp}
	
Installing latest alarmcfg module if not installed on server
	${zip_name}    Split String From Right    ${temp}    /
    Execute Command    cd /eniq/sw/installer ; chmod u+x ${zip_name}[-1] 
    ${output}    Execute Command    cd /eniq/sw/installer ; ./platform_installer ${zip_name}[-1] 
    ${failed}    Evaluate    'failed' in '''${output}'''    
    IF    ${failed}
        Fail    *HTML* <span style="color:red"><b>${alarmcfg_module} installation Failed.</b></span>${\n}${output}
    ELSE
        Log    <span style="color:green"><b>${alarmcfg_module} installed Successfully.${\n}Proceeding with log verification.</b></span>    html=True
    END
	
Verifying if latest alarmcfg module got installed on server
	${out}    Execute Command    cat /eniq/sw/installer/versiondb.properties | grep -i ${alarmcfg_module}=
    ${latest}    Evaluate    '${rstate}' in '''${out}'''
    IF    ${latest}
        Log    <span style="color:green"><b>Latest ${alarmcfg_module} rstate is present in versiondb.properties file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>${alarmcfg_module} latest rstate not matching in versiondb.properties file.</b></span>${\n}${out}
    END
	
Verifying if latest alarmcfg module is present on adminUI page.
	Select From List By Label    //select[@name="command"]    Installed modules
    Click Button    Start
    Element should Contain    //input[@value='Start']/following::table[1]//td    ${alarmcfg_name1}   

Getting latest alarmcfg log file and verifying no error should be there
	${zip_name}    Split String From Right    ${temp}    /
    ${out}    ${rc}    Execute Command   cd /eniq/log/sw_log/platform_installer; filename=$(ls -Art ${zip_name}[-1]*.log | tail -n 1); cat $filename | grep -i "warning\|exception\|severe\|not found\|error"    return_rc=True
    IF    ${rc} == 1
        Log    <span style="color:green"><b>No negative keywords are found in ${zip_name}[-1].log file.</b></span>    html=True
    ELSE
        Fail    *HTML* <span style="color:red"><b>Negative keywords found in ${zip_name}[-1].log file.</b></span>${\n}${out}
    END


Verify no reports are added
    ${check_interface_empty}=    Run Keyword And Return Status    Element Should Contain    id:action_title    No reports
    IF    ${check_interface_empty} == True
        Log    No reports are present
    ELSE
        ${count_added_reports}=    Get Element Count    //img[@alt='Remove']
        Log To Console    Total Alarmcfg reports: ${count_added_reports}
        FOR    ${counter}    IN RANGE    0    ${count_added_reports}    
            Click Element    xpath://img[@alt="Remove"]
            Handle Alert    timeout=10s  
            Verify message is displayed    successfully removed     
            Sleep    2s
        END   
        Click Interface link    5min
        Element Should Contain    id:action_title    No reports  
    END

Adding datebase file in SERVER
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /eniq/home/dcuser

Check server time for alarmcfg reports   
    ${almcfg_current_datetime_db}=    Execute Command    cat /var/tmp/almreport_db_add_time.txt
    Set Global Variable    ${almcfg_current_datetime_db}


Verify target reports are not added
    [Arguments]    ${intf_basetable_args}    ${alm_template_args}     ${alm_intf_time_args}
    ${check_interface_empty}=    Get Text    id:main_column
    ${check_interface_empty}=    Run Keyword And Return Status     Should Not Contain    ${check_interface_empty}    ${alm_template_args}    
    IF    ${check_interface_empty} == True
        Log    Adding reports
    ELSE
        ${count_added_reports}=    Get Element Count    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]   
        FOR    ${counter}    IN RANGE    0    ${count_added_reports}    
            Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Remove"]
            Handle Alert    timeout=10s  
            Verify message is displayed    successfully removed     
            Sleep    2s
        END   
        Click Interface link     ${alm_intf_time_args}
        ${check_interface_empty}=    Get Text    id:main_column 
        Should Not Contain    ${check_interface_empty}    ${alm_template_args}        
    END

Verify Alarmcfg webpage logged in successfully
    RPA.Browser.Selenium.Click Button     xpath://*[@value='Login']
    RPA.Browser.Selenium.Wait Until Page Contains   Logout    timeout=120
    Sleep    2s