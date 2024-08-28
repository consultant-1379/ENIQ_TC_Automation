*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Engine.robot
Suite Teardown    Close All Connections




*** Test Cases ***
Verify the check repdb and engine status when we shut down REP database using CLI
    Connect to server as a dcuser
    ${repdb_stop}=    Execute Command    /eniq/sw/bin/repdb stop 
    Verify the msg    ${repdb_stop}    Service stopping eniq-repdb
    ${repdb_status}=    Execute Command    /eniq/sw/bin/repdb status
    Verify the msg    ${repdb_status}    repdb is not running
    ${engine_status}=    Execute the command    engine status
    Verify the msg    ${engine_status}    Current Profile: Normal
    Verify the msg    ${engine_status}    engine is running OK
    Verify the msg    ${engine_status}   lwp helper is running
    Verify the repdb stop log

Verify the check repdb and engine status when we shut down REP database using adminui
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Loader status error
    Logout from Adminui
    Close Browser

Verify the Check engine logs when we shutdown repdb using CLI
    Connect to server as a dcuser
    ${date}    Execute command    date '+%Y_%m_%d'
    Execute the Command    cd /eniq/log/sw_log/engine
    ${grepError_results}=    Execute the Command    cat engine-${date}.log | grep -i Error
    Verify the msg    ${grepError_results}    Error 
    
    
    

Verify the Check repdb and engine status when we start REP database using CLI
    ${repdb_status}=    Execute Command     /eniq/sw/bin/repdb start 
    Verify the msg    ${repdb_status}    Service enabling eniq-repdb
    ${repdb_status}=    Execute Command     /eniq/sw/bin/repdb status
    Verify the msg    ${repdb_status}    repdb is running OK
    ${engine_status}=    Execute the command    engine status
    Verify the msg    ${engine_status}    Current Profile: Normal
    Verify the msg    ${engine_status}    engine is running OK
    Verify the msg    ${engine_status}   lwp helper is running
    Verify the repdb start log

Verify the Check repdb and engine status when we start REP database using adminui
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the status colour is displayed in webpage    6    green        
    Verify the status colour is displayed in webpage    2    green        
    Verify module status is displayed in webpage    Engine    Green    
    Click on Engine Status link
    Switch window to new Engine status details tab
    Click on scroll down button
    Verify the engine service in AdminUI page
    Switch window to back to Adminui tab
    Click on scroll down button
    Logout from Adminui
    Close Browser
    [Teardown]    Test teardown  

    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
  
Test Teardown
    ${repdb_return_status}=    Run Keyword And Return Status    Verify the repdb status    
    IF    ${repdb_return_status} == True
        Log To Console    repdb is running OK    
    ELSE
        ${repdb_status}=    Execute Command     /eniq/sw/bin/repdb start
    END   
