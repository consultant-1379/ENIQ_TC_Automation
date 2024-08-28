** Settings ***
Documentation     Testing Monitoring web
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot 
Resource    ../../Resources/Keywords/Monitoring.robot

*** Test Cases ***
Verify latest module in AdminUI
    ${monitoring_file}    Get the element of monitoring attribute from clearcase
    ${monitoring_rstate_buildno_clearcase}    Get monitoring Rstate from clearcase    ${monitoring_file}
    Connect to server as a dcuser
    ${rstate_buildno_server}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i monitoring
    ${output}    Remove String Using Regexp    ${rstate_buildno_server}    .*monitoring\\S
    Should Be Equal    ${monitoring_rstate_buildno_clearcase}    ${output}
    Launch the AdminUI page in browser
    Login To Adminui
    Go to system monitoring and select installed modules
    Page Should Contain    ${rstate_buildno_server}
    Logout from Adminui
    
*** Keywords ***
Test Teardown
    Close All Connections