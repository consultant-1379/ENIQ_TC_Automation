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
    ${Installer_file}    Get the element of installer attribute from clearcase
    ${Installer_rstate_buildno_clearcase}    Get Installer Rstate from clearcase    ${Installer_file}
    Connect to server as a dcuser
    ${rstate_buildno_server}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i installer
    ${output}    Remove String Using Regexp    ${rstate_buildno_server}    .*installer\\S
    #Should Be Equal    ${Installer_rstate_buildno_clearcase}    ${output}
    Launch the AdminUI page in browser
    Login To Adminui
    Go to system monitoring and select installed modules
    Page Should Contain    module.installer=${output}
    Logout from Adminui

*** Keywords ***
Test Teardown
    Close All Connections
    

Get the element of installer attribute from clearcase
    Open Available Browser    ${clearcase_url}     headless=false
    Maximize Browser Window
    click link    //body//tr[last()-2]//td[2]//a
    ${installer_file}=    Get Element Attribute    //a[contains(text(),'installer')]    href
    Go To    ${installer_file}
    RETURN    ${installer_file}

Get installer Rstate from clearcase
    [Arguments]    ${installer_file}
    ${installer_zip_file}=    Fetch From Right    ${installer_file}    r_
    ${installer_rstate_buildno_clearcase}=    Fetch From Left    ${installer_zip_file}    .
    RETURN    ${installer_rstate_buildno_clearcase}