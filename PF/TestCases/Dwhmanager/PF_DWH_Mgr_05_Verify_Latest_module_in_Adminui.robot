*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot 
Resource    ../../Resources/Keywords/Dwhmanager.robot

*** Test Cases ***
Verify latest module in AdminUI
    ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
    ${dwhmanager_rstate_buildno_clearcase}    Get dwhmanager Rstate from clearcase    ${dwhmanager_file}
    Connect to server as a dcuser
    ${rstate_buildno_server}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i dwhmanager
    ${output}    Remove String Using Regexp    ${rstate_buildno_server}    .*dwhmanager\\S
    Should Be Equal    ${dwhmanager_rstate_buildno_clearcase}    ${output}
    Launch the AdminUI page in browser
    Login To Adminui
    Go to system monitoring and select installed modules
    Page Should Contain    ${rstate_buildno_server}
    Logout from Adminui

*** Keywords ***
Test Teardown
    Close All Connections
    