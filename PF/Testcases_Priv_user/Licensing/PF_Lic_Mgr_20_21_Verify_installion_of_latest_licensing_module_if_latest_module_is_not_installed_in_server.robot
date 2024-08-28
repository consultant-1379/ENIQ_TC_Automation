*** Settings ***
Documentation     Testing License Status in Adminui web
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Library    String
Library    Collections
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Test Cases ***
Verify the licensing version is updated in versiondb.properties
    ${licensing_file}    Get the element of licensing attribute from clearcase
    ${licensing_rstate_buildno_clearcase}    Get licensing Rstate from clearcase    ${licensing_file}
    ${licensing_rstate_buildno_server}    Get licensing version from server
    ${licensing_rstate_status}    Verify the latest licensing version is updated in versiondb.properties file    ${licensing_rstate_buildno_clearcase}    ${licensing_rstate_buildno_server}
    Set Global Variable    ${licensing_rstate_status}

Verify the installation of latest licensing module
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
    Connect to server as a dcuser 

Suite teardown steps
    Capture Page Screenshot
    Close Browser
    Close All Connections
