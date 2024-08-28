*** Settings ***
Library    SSHLibrary
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Engine.robot
Suite Teardown    Close All Connections



*** Test Cases ***
Verify the Check dwhdb stop and engine status when we shut down DWH database using CLI
    Connect to server as a dcuser
    ${dwhdb_stop}=    Execute Command    /eniq/sw/bin/dwhdb stop
    Verify the msg    ${dwhdb_stop}    Service stopping eniq-dwhdb
    ${dwhdb_status}=    Execute Command    /eniq/sw/bin/dwhdb status
    Verify the msg    ${dwhdb_status}    dwhdb is not running
    ${engine_status}=    Execute the Command    engine status
    Verify the msg    ${engine_status}    Completed successfully
    Verify the msg    ${engine_status}    engine is running OK
    Verify the msg    ${engine_status}   lwp helper is running
    Verify the dwhdb stop log

Verify the Check dwhdb status and engine status when we shut down DWH database connection in adminui
    Launch the AdminUI page in browser
    Login To Adminui with Handle alert
    Click on button    System Status
    Handle Alert
    Verify the status colour is displayed in webpage    1    red   
    Verify module status is displayed in webpage    ENIQ DWH    Red                   
    Vaildate the database connection error in adminui
    Click on scroll down button
    Logout from Adminui
    Close Browser

Verify the Check dwhdb status and engine status when we shut down DWH database in adminui
    Launch the AdminUI page in browser
    Login To Adminui with Handle alert
    Click on button    System Status
    Handle Alert
    Verify the status colour is displayed in webpage    1    red
    Verify module status is displayed in webpage    ENIQ DWH    Red     
    Vaildate the counter volume information error
    Click on scroll down button
    Logout from Adminui
    Close Browser

Verify the Check dwhdb start and engine status when we shut down DWH database using CLI
    Connect to server as a dcuser
    ${dwhdb_start}=    Execute Command    /eniq/sw/bin/dwhdb start
    Verify the msg    ${dwhdb_start}    Service enabling eniq-dwhdb
    ${dwhdb_status}=    Execute Command    /eniq/sw/bin/dwhdb status
    Verify the msg    ${dwhdb_status}    dwhdb is running OK
    ${engine_status}=    Execute the Command    engine status
    Verify the msg    ${engine_status}    Completed successfully
    Verify the msg    ${engine_status}    engine is running OK
    Verify the msg    ${engine_status}   lwp helper is running
    Verify the dwhdb start log
    

Verify the Check dwhdb status and engine status when we start DWH database in adminui
    Launch the AdminUI page in browser
    Login To Adminui with Handle alert
    Verify the status colour is displayed in webpage    1    green    
    Verify the status colour is displayed in webpage    6    green    
    Verify the ENIQ DWH status colours in adminui
    Verify the Engine status colours in adminui       
    Click on scroll down button
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    ${dwhdb_return_status}=    Run Keyword And Return Status    Verify the dwhdb status    
    IF    ${dwhdb_return_status} == True
        Log To Console    dwhdb is running OK    
    ELSE
        ${dwhdb_start}=    Execute Command    /eniq/sw/bin/dwhdb start
    END   

