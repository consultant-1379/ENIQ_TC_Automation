*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot

*** Test Cases ***
Verify latest module in CLI
    ${installer_file}    Get the element of installer attribute from clearcase
    ${installer_rstate_buildno_clearcase}    Get installer Rstate from clearcase    ${installer_file}
    Connect to server as a dcuser
    ${installer_rstate_buildno_server}    Get installer version from server
    Should be equal    ${installer_rstate_buildno_clearcase}    ${installer_rstate_buildno_server}

*** Keywords ***
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

Get installer version from server
    ${rstate_8399}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i installer
    ${installer_rstate}    Split String    ${rstate_8399}    installer=
    ${installer_rstate_buildno_server}=    Get From List    ${installer_rstate}    -1
    ${output}    Remove String Using Regexp    ${installer_rstate_buildno_server}    .*installer\\S
    RETURN    ${output}
Test Teardown
    Close All Connections