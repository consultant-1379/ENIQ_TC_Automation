*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot

*** Test Cases ***
Verify the Installer version is updated in versiondb.properties
    ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
    ${dwhmanager_rstate_buildno_clearcase}    Get dwhmanager Rstate from clearcase    ${dwhmanager_file}
    Connect to server as a dcuser
    ${dwhmanager_rstate_buildno_server}    Get dwhmanager version from server
    ${rstate_status}    Verify the latest dwhmanager version is updated in versiondb.properties file    ${dwhmanager_rstate_buildno_clearcase}    ${dwhmanager_rstate_buildno_server}
    Set Global Variable    ${rstate_status}

*** Keywords ***
Test Teardown
    Close All Connections