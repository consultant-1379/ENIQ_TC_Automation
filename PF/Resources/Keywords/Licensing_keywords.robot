*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    DateTime
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Variables.robot
	
*** Keywords ***
Set time delay
    Set Selenium Speed    1s

Verify command output
    [Arguments]    ${output_args}    ${expected_result_args}
    Should Contain    ${output_args}    ${expected_result_args}    ignore_case=True
    Sleep    1s

Start License Manager
    ${start_licmgr}=    Execute Command    /eniq/sw/bin/licmgr -start
    Log To Console     ${start_licmgr}
    Verify command output    ${start_licmgr}    enabling eniq-licmgr

Stop License Manager
    ${start_licmgr}=    Execute Command    /eniq/sw/bin/licmgr -stop
    Log To Console     ${start_licmgr}
    Verify command output    ${start_licmgr}    stopping eniq-licmgr

Restart License Manager
    ${start_licmgr}=    Execute Command    /eniq/sw/bin/licmgr -restart
    Log To Console     ${start_licmgr}
    Verify command output    ${start_licmgr}    stopping eniq-licmgr
    Verify command output    ${start_licmgr}    enabling eniq-licmgr

Verify License manager status in server
    [Arguments]    ${licmgr_status_args}
    ${licmgr_status}=    Execute Command    /eniq/sw/bin/licmgr -status
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    ${licmgr_status_args} 

Verify module status is displayed in webpage
    [Arguments]    ${module_name_args}    ${module_status_args}
    Page Should Contain element    xpath://font[contains(text(),"${module_name_args}")]/parent::td/preceding-sibling::td/img[@alt="${module_status_args}"]
    Sleep    1s

Verify command output with regex
    [Arguments]    ${cmd_out_args}    ${expected_result_args}
    Should Match Regexp   ${cmd_out_args}    ${expected_result_args}

Verify licensemanager stopped message in licmgr logs
    [Arguments]    ${current_log_args}
    ${check_licmgr_log}=    Execute Command    tail -10 /eniq/log/sw_log/licensemanager/${current_log_args}
    Log To Console    ${check_licmgr_log}
    Should Contain    ${check_licmgr_log}    License manager is not running

Get licensemanager log file for current date
    ${current_date}=    Execute Command   date +%Y_%m_%d
    Log To Console    ${current_date}
    ${get_current_licmgr_log}=    Execute Command    ls /eniq/log/sw_log/licensemanager/ | grep -i "${current_date}.log$"
    Log To Console    ${get_current_licmgr_log}
    Should Not Be Empty    ${get_current_licmgr_log}
    [Return]    ${get_current_licmgr_log}

Verify licmgr when licmgr restarted
    Restart License Manager
    ${licmgr_status}=    Execute Command    /eniq/sw/bin/licmgr -status
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    License manager is running OK

Click Show Installed license link
    Click Link    xpath://a[text()="Show installed licenses"]
    Wait Until Page Contains    Installed licenses    timeout=40s
    Sleep    2s

Get Installed license features list displayed in webpage
    ${get_data}=    Get Text    xpath://font[contains(text(),'System Monitoring')]/parent::td
    ${get_features_list}=    Get Regexp Matches    ${get_data}    \\bCXC.*\\d+\\b 
    ${adminui_features_list}=    Remove Duplicates    ${get_features_list}
    Sort List    ${adminui_features_list}
    Log To Console    Installed license features displayed in Adminui: ${adminui_features_list}
    Should Not Be Empty    ${adminui_features_list}
    [Return]    ${adminui_features_list}    

Get license Installed features list in server
    ${server_features_data}=    Execute Command    /eniq/sw/bin/licmgr -getlicinfo | grep -i "CXC" | cut -d ':' -f 2- | awk '{print $1}'
    @{server_features_list}=    Split To Lines     ${server_features_data}
    Sort List    ${server_features_list}
    Log To Console    Installed license features in server: ${server_features_list}
    Should Not Be Empty    ${server_features_list}
    [Return]    ${server_features_list}

Verify Installed licenses features list in Admniui webpage is present in server
    [Arguments]     ${server_installed_features_args}    ${adminui_installed_features_args}
    List Should Contain Sub List    ${server_installed_features_args}    ${adminui_installed_features_args}
    
Verify license manager and engine status  
    Write    licmgr -status
    ${license_manager_status}    Read    delay=3s
    Should Contain    ${license_manager_status}    License manager is running OK
    Write    engine status
    ${engine_status}    Read    delay=3s
    Should Contain    ${engine_status}    engine is running OK

Getting latest file from the folder
    [Arguments]    ${folder_name}    ${file_name}
    ${getting_latest_file}=    Execute Command    ls ${folder_name}|grep ${file_name}|tail -1
    Log To Console    ${getting_latest_file}
    [Return]    ${getting_latest_file}

Opening the licensing latest file and searching for failure
    [Arguments]    ${latest_file}
    ${licensing_error_log}    ${rc}=    Execute Command    awk '/License manager is running OK/ {data = ""} {data = data $0 RS} END {print data}' /eniq/log/sw_log/licensemanager/${latest_file} |grep -i 'FAILED\\|EXCEPTION\\|warning\\|severe\\|not found\\|failed\\|Error\'    return_rc=True    
    ${output_length}    Get Length    ${licensing_error_log}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "No Error in log file"
    ELSE
         Should Contain Any    ${licensing_error_log}    License manager updated    License Manager Cache Update    Retrying
    END
       

verify logs should not contain faliure
    [Arguments]    ${failure_logs}
    Should Be Empty    ${failure_logs}

Verify the status of license server and License manager
    Write    cd /eniq/sw/bin
    Write    licmgr -serverstatus
    ${server_status}    Read    delay=2s
    Should Contain    ${server_status}    is online
    Write    licmgr -status
    ${license_manager_status}    Read    delay=3s 
    Should Contain    ${license_manager_status}    License manager is running OK

Verify the License log page displayed
    Page Should Contain    Select date from which you wish to fetch the licensing logs

Comparing expiring date with current date of starter license
    Write    /eniq/sw/bin/licmgr -getlicinfo | grep -i -e 'starter' -e 'CXC4012419' -C 2 |grep -i Expiration | cut -d ':' -f 2- |awk '{print $1,$2,$3}'|tail -1
    ${expiary_date1}    Read    delay=3s 
    ${expiary_date}    Should Match Regexp    ${expiary_date1}    \\b\\w*\\s\\d*,\\s\\d*\\b
    ${converted_date}    convert date    ${expiary_date}    date_format=%b %d, %Y    result_format=%Y/%m/%d
    Log To Console    ${converted_date}
    ${current_date}=    Get Current Date    result_format=%Y/%m/%d
    Log To Console    ${current_date}
     IF     '${converted_date}' > '${current_date}'
        ${License_expire}    Set Variable    False
    ELSE
        ${License_expire}    Set Variable    True
    END
    [Return]    ${license_expire}

Comparing expiring date with current date of capacity license
    Write    /eniq/sw/bin/licmgr -getlicinfo | grep -i -e 'starter' -e 'CXC4012419' -C 2 |grep -i Expiration | cut -d ':' -f 2- |awk '{print $1,$2,$3}'|tail -1
    ${expiary_date1}    Read    delay=3s 
    ${expiary_date}    Should Match Regexp    ${expiary_date1}    \\b\\w*\\s\\d*,\\s\\d*\\b
    ${converted_date}    convert date    ${expiary_date}    date_format=%b %d, %Y    result_format=%Y/%m/%d
    Log To Console    ${converted_date}
    ${current_date}=    Get Current Date    result_format=%Y/%m/%d
    Log To Console    ${current_date}
     IF     '${converted_date}' > '${current_date}'
        ${License_expire}    Set Variable    False
    ELSE
        ${License_expire}    Set Variable    True
    END
    [Return]    ${license_expire}

Verify if starter license is expired or not
    ${license_expired_status}    Comparing expiring date with current date of starter license   
    IF    '${license_expired_status}' == 'False'
        Write    engine status
        ${status_of_engine}    Read    delay=10s
        Should Contain    ${status_of_engine}    engine is running OK
        Should Contain    ${status_of_engine}    Status: active
        Log To Console    License is not expired
    ELSE
        Fail    License is expired
    END

Verify if capacity license is expired or not
    ${license_expired_status}    Comparing expiring date with current date of capacity license   
    IF    '${license_expired_status}' == 'False'
        Write    engine status
        ${status_of_engine}    Read    delay=10s
        Should Contain    ${status_of_engine}    engine is running OK
        Should Contain    ${status_of_engine}    Status: active
        Log To Console    License is not expired
    ELSE
        Fail    License is expired
    END

Verify status of Scheduler 
    ${license_expired_status}    verify if license is expired or not  
    IF    '${license_expired_status}' == 'False'
        Write    scheduler status
        ${status_of_engine}    Read    delay=2s
        Should Contain    ${status_of_engine}    scheduler is running OK
        Should Contain    ${status_of_engine}    Status: active
    ELSE
        Write     scheduler status
        ${status_of_engine}    Read    delay=2s
        Should Contain    ${status_of_engine}    scheduler is not running 
        Should Contain    ${status_of_engine}    Status: inactive
    END
    

Copying latest release from MWS path to server and doing license installation
    ${latest_release}    Execute Command    ls /net/10.45.192.153/JUMP/|grep -i -o 'ENIQ_S[0-9][0-9].[0-9]'| tail -1
    Log To Console    ${latest_release}
    Write    scp -r ${mws_paths}${latest_release} /var/tmp
    Write    licmgr -install /var/tmp/${latest_release}
    ${value}    Read    delay=3s
    [Return]    ${value}

Copying latest release from MWS path to server and doing license installation on MB
    ${latest_release}    Execute Command    ls /net/ieatrcx8190/JUMP/|grep -i -o 'ENIQ_S[0-9][0-9].[0-9]'| tail -1
    Log To Console    ${latest_release}
    Write    scp -r ${ipv6_mws_paths}${latest_release} /var/tmp
    Read    delay=4s
    Write    su - dcuser
    Read    delay=4s
    Write    licmgr -install /var/tmp/${latest_release}
    ${value}    Read    delay=4s
    [Return]    ${value}

Verify license got installed
    ${license_installation_status}    Copying latest release from MWS path to server and doing license installation 
    Should Contain    ${license_installation_status}    Updating license manager
    Should Not Contain    ${license_installation_status}    Could not install feature

Verify license got installed on MB
    ${license_installation_status}    Copying latest release from MWS path to server and doing license installation on MB 
    Should Contain    ${license_installation_status}    Updating license manager
    Should Not Contain    ${license_installation_status}    Could not install feature 

verify License server and License manager should be in red color when expired
    ${license_expired_status}    verify if license is expired or not
    IF    '${license_expired_status}' == 'True'
        Page Should Contain Element    xpath://font[contains(text(),"License server")]/parent::td/preceding-sibling::td/img[@alt="Red"]
        Page Should Contain Element    xpath://font[contains(text(),"License manager")]/parent::td/preceding-sibling::td/img[@alt="Red"]
    END

verify if license is expired or not
    ${starter_license_expire}    Comparing expiring date with current date of starter license  
    ${capacity_license_expire}    Comparing expiring date with current date of capacity license
    IF    ${starter_license_expire} == False and ${capacity_license_expire}==False
        ${continue_license_testcases}    Set Variable    False
        Log To Console    License is not expired
    ELSE
        ${continue_license_testcases}    Set Variable    True
        Log To Console    License is expired
    END
    [Return]    ${continue_license_testcases}

Get licensing Rstate from clearcase
    [Arguments]    ${licensing_file}
    ${licensing_zip_file}=    Fetch from Right    ${licensing_file}    _
    ${licensing_rstate_buildno_clearcase}=    Fetch From Left    ${licensing_zip_file}    .
    Log To Console    license rstate in clearcase: ${licensing_rstate_buildno_clearcase}
    [Return]    ${licensing_rstate_buildno_clearcase}
	
Get licensing version from server
    ${rstate_8399}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i licensing
    ${licensing_rstate}    Split String    ${rstate_8399}    licensing=
    ${licensing_rstate_buildno_server}=    Get From List    ${licensing_rstate}    -1
    Log To Console    license rstate in server: ${licensing_rstate_buildno_server}
    [Return]    ${licensing_rstate_buildno_server}
	
Verify the latest licensing version is updated in versiondb.properties file
    ${status_of_latest_licensing}=    Set Variable    True
    [Arguments]    ${rstate_clearcase}    ${licensing_rstate_8399}
    IF    '${rstate_clearcase}' == '${licensing_rstate_8399}'
        ${status_of_latest_licensing}=    Set Variable    True
    ELSE
        ${status_of_latest_licensing}=    Set Variable    False
    END
    Log To Console    ${status_of_latest_licensing}
    [Return]    ${status_of_latest_licensing}

Install latest licensing package
    [Arguments]    ${licensing_file}
    Execute Command     cd /eniq/sw/installer/ && rm -rf licensing_*
    ${licensing_zip_file}=    Fetch from Right    ${licensing_file}    /
    Execute Command    cd /eniq/sw/installer/ && wget ${licensing_file}
    Execute Command    cd /eniq/sw/installer/ && chmod u+x ${licensing_zip_file}  
    Write    cd /eniq/sw/installer/ ; ./platform_installer ${licensing_zip_file}
    ${staus_licensing}=    Read    delay=30s
    Log To Console    ${staus_licensing}
    [Return]    ${staus_licensing}

Get the element of licensing attribute from clearcase
    Open Available Browser    ${clearcase_url}    headless=false  
    Maximize Browser Window
    Click link    //body//tr[last()-2]//td[2]//a
    ${licensing_file}=    Get Element Attribute    //a[contains(text(),'licensing')]    href
    Go To    ${licensing_file}
    Log To Console    ${licensing_file}
    [Return]    ${licensing_file}

Verify Successfully installation of licensing package
    [Arguments]    ${staus_licensing}
    Should Contain    ${staus_licensing}    Successfully installed

Verify the latest licensing version is updated after installation in versiondb.properties file
    [Arguments]    ${rstate_status_clearcase_args}    ${rstate_status_server_args} 
    Should Be Equal    ${rstate_status_clearcase_args}    ${rstate_status_server_args}

Verify eniq service is loaded active and running
    [Arguments]    ${eniq_service_args}
    ${rmiregistry_status}=    Execute Command    systemctl -t service | grep -i ${eniq_service_args} | grep -i "\\bloaded\\s*active\\s*running\\b"
    Log To Console     ${rmiregistry_status}  
    Should Not Be Empty    ${rmiregistry_status} 

Verify eniq service is active
    [Arguments]    ${eniq_service_args}
    ${status_active}=    Execute Command    /eniq/installation/core_install/bin/list_services.bsh -s ${eniq_service_args}
    Log To Console    ${status_active}

Verify nas service is present in server
    ${server_type}=    Execute Command    cat /etc/hosts
    Should Not Be Empty    ${server_type}
    ${blade_multiblade_servers}=    Run Keyword And Return Status    Should Contain   ${server_type}    nasconsole
    [Return]    ${blade_multiblade_servers} 

Get license Installed features list in privileged user server
    ${server_features_data}=    Execute Command    sudo su - dcuser -c """licmgr -getlicinfo | grep -o -iE '\\bCXC[0-9]+\\b'"""
    @{server_features_list}=    Split To Lines     ${server_features_data}
    Sort List    ${server_features_list}
    Log To Console    Installed license features in server: ${server_features_list}
    Should Not Be Empty    ${server_features_list}
    [Return]    ${server_features_list}



