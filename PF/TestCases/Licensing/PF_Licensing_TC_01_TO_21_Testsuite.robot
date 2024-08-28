*** Settings ***
Library    SSHLibrary
Documentation     Testing License Status in Adminui web
Library    RPA.Browser.Selenium  
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Licensing_Keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Library    String
Library    Collections
Suite Setup    Connect to server
Suite Teardown    Close All Connections
 
 
*** Test Cases ***
TC_01 Verify the count of installed license using command line
    Connect to server as a dcuser
    ${getting_latest_release_value}    Execute Command    ls /net/10.45.192.153/JUMP/|grep -i -o 'ENIQ_S[0-9][0-9].[0-9]'| tail -1
    Log To Console    ${getting_latest_release_value}
    ${license_count_from_mws_path}    Execute Command    cat /net/10.45.192.153/JUMP/${getting_latest_release_value} | grep -iE -o '\\"CXC[0-9]{7}\\"' | wc -l
    Log To Console    ${license_count_from_mws_path}
    ${license_count_installed}    Execute Command    /eniq/sw/bin/licmgr -getlicinfo | grep -o -iE 'CXC[0-9]{7}' | wc -l
    Log To Console    ${license_count_installed}
    Should Be Equal    ${license_count_from_mws_path}    ${license_count_installed}  
 
TC_02 Verify installed licenses showing in Adminui webpage
    Set time delay
    AdminUIWebUI.Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    AdminUIWebUI.Login To Adminui
    Click Show Installed license link
    ${adminui_installed_features}=    Get Installed license features list displayed in webpage
 
    #installed license features in server
    Connect to server as a dcuser
    ${server_installed_features}=    Get license Installed features list in server
    Verify Installed licenses features list in Admniui webpage is present in server    ${server_installed_features}    ${adminui_installed_features}
    #[Teardown]    Test teardown
 
TC_03 Verify the condition when Starter License get expired.
    Connect to server as a dcuser
    Comparing expiring date with current date of starter license
    Verify if starter license is expired or not
 
TC_04 Verify the condition when Capacity License get expired.
    Connect to server as a dcuser
    Comparing expiring date with current date of capacity license
    Verify if capacity license is expired or not
 
TC_05 Check for license manager and scheduler services when license gets expired
    Connect to server as a dcuser
    Verify status of Scheduler
 
TC_06 Verify adminui status when license gets expired
    AdminUIWebUI.Launch the AdminUI page in browser
    AdminUIWebUI.Login to Adminui
    Click Button    System Status
    AdminUIWebUI.Verify the System Status page displayed
    AdminUIWebUI.Logout from Adminui
    Connect to server as a dcuser
    verify License server and License manager should be in red color when expired
    #[Teardown] Test teardown
 
TC_07 verify licensing log for any failures
    Connect to server as a dcuser
    ${latest_file}=    Getting latest file from the folder    ${license_folder}    ${latest_licensemanager_file}
    ${faliure_logs}=    Opening the licensing latest file and searching for failure    ${latest_file}
    #verify logs should not contain faliure   ${faliure_logs}    
 
TC_08 Verify the installation of license from file using command line
    Connect to server as a dcuser
    #Copying latest release from MWS path to server and doing license installation
    Verify license got installed
 
TC_09 Verify status of License Server and License Manager
    Set time delay
    AdminUIWebUI.Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    AdminUIWebUI.Login To Adminui
    Licensing_Keywords.Verify module status is displayed in webpage    License server    Green
    Licensing_Keywords.Verify module status is displayed in webpage    License manager    Green
    AdminUIWebUI.Logout from Adminui
    #[Teardown]    Test teardown
 
TC_10 Verify the status of license server and License manager from command line
    Connect to server as a dcuser
    Verify the status of license server and License manager
 
TC_11 Verify license manager status when we start license manager
    Wait Until Keyword Succeeds    2x    10s    Start License Manager
    ${licmgr_status}=    Execute Command    /eniq/sw/bin/licmgr -status
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    License manager is running OK
   
TC_12 Verify engine status when we start license manager
    ${engine_status}=    Execute Command   /eniq/sw/bin/engine status
    Log To Console     ${engine_status}
    Verify command output    ${engine_status}    Status: active
    Verify command output    ${engine_status}    cache status : initialized
    Verify command output    ${engine_status}    Current Profile: Normal
    Verify command output    ${engine_status}    engine is running OK
    Verify command output    ${engine_status}    lwp helper is running
 
TC_13 Verify license manager status when we stop license manager
    Wait Until Keyword Succeeds    2x    10s    Stop License Manager    
    Verify License manager status in server    License manager is not running
    ${current_licmgr_log_file}=    Get licensemanager log file for current date
    Sleep    40s
    Wait Until Keyword Succeeds    3x    40s    Verify licensemanager stopped message in licmgr logs    ${current_licmgr_log_file}
   
TC_14 Verify engine status when we stop license manager
    ${engine_status}=    Execute Command   /eniq/sw/bin/engine status
    Log To Console     ${engine_status}
    Verify command output    ${engine_status}    Status: active
    Verify command output    ${engine_status}    cache status : initialized
    Verify command output    ${engine_status}    Current Profile: Normal
    Verify command output    ${engine_status}    engine is running OK
    Verify command output    ${engine_status}    lwp helper is running
 
TC_15 Verify license manager status when we restart license manager
    Wait Until Keyword Succeeds    2x    10s    Restart License Manager
    Verify License manager status in server    License manager is running OK
   
TC_16 Verify engine status when we restart license manager
    ${engine_status}=    Execute Command   /eniq/sw/bin/engine status
    Log To Console     ${engine_status}
    Verify command output    ${engine_status}    Status: active
    Verify command output    ${engine_status}    cache status : initialized
    Verify command output    ${engine_status}    Current Profile: Normal
    Verify command output    ${engine_status}    engine is running OK
    Verify command output    ${engine_status}    lwp helper is running
    #[Teardown]    Test Teardown  
 
TC_17 Verify whether rmiregistry and nas services are up and running
    ${nas_service_available}=    Verify nas service is present in server
    IF    ${nas_service_available} == True
        Verify eniq service is loaded active and running    rmiregistry    
        Verify eniq service is loaded active and running    nasd
        Verify eniq service is loaded active and running    nas-online
    ELSE
        Verify eniq service is loaded active and running    rmiregistry  
    END
 
TC_18 Verify scheduler and engine services when license is not expired
    ${licmgr_status}=    Execute Command    /eniq/sw/bin/licmgr -status
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    License manager is running OK
 
    ${eniq_engine_status}=    Execute Command    /eniq/sw/bin/engine status
    Log To Console    ${eniq_engine_status}
    Verify command output    ${eniq_engine_status}    Status: active
    Verify command output    ${eniq_engine_status}    cache status : initialized
    Verify command output    ${eniq_engine_status}    Current Profile: Normal
    Verify command output    ${eniq_engine_status}    engine is running OK
    Verify command output    ${eniq_engine_status}    lwp helper is running
 
    ${eniq_scheduler_status}=    Execute Command    /eniq/sw/bin/scheduler status
    Log To Console    ${eniq_scheduler_status}
    Verify command output    ${eniq_scheduler_status}    Status: active
 
TC_19 Verify the count of installed license using command line
    Connect to server as a dcuser
    ${faj_value}    Set Variable    FAJ8010774
    ${cxc_value}    Set Variable    CXC4012419
    ${mapping}    Execute Command    /eniq/sw/bin/licmgr -map faj ${cxc_value}
    Log To Console    ${mapping}
    Should Be Equal    ${mapping}    ${faj_value}
 
Tc_20 Verify the licensing version is updated in versiondb.properties
    ${licensing_file}    Get the element of licensing attribute from clearcase
    ${licensing_rstate_buildno_clearcase}    Get licensing Rstate from clearcase    ${licensing_file}
    ${licensing_rstate_buildno_server}    Get licensing version from server
    ${licensing_rstate_status}    Verify the latest licensing version is updated in versiondb.properties file    ${licensing_rstate_buildno_clearcase}    ${licensing_rstate_buildno_server}
    Set Global Variable    ${licensing_rstate_status}
 
TC_21 Verify the installation of latest licensing module
    IF    '${licensing_rstate_status}' == 'True'
        Skip    licensing version from clearcase and server is same  
    ELSE
        ${licensing_file}    Get the element of licensing attribute from clearcase
        ${staus_licensing}    Install latest licensing package     ${licensing_file}
        Verify Successfully installation of licensing package    ${staus_licensing}
        ${lic_rstate_clearcase}    Get licensing Rstate from clearcase    ${licensing_file}
        ${lic_rstate_after_install}    Get licensing version from server
        Verify the latest licensing version is updated after installation in versiondb.properties file     ${lic_rstate_clearcase}    ${lic_rstate_after_install}    
    END
 
 
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
 
Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections
 
Test Teardown
    ${license_return_status}=    Run Keyword And Return Status    Verify License manager status in server    License manager is running OK    
    IF    ${license_return_status} == True
        Log To Console    License manager status is OK    
    ELSE
        Wait Until Keyword Succeeds    2x    10s    Start License Manager
        Verify License manager status in server    License manager is running OK
    END