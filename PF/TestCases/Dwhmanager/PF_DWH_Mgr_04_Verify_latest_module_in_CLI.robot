*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot

*** Test Cases ***
Verify latest module in CLI
    ${dwhmanager_file}    Get the element of dwhmanager attribute from clearcase
    ${dwhmanager_rstate_buildno_clearcase}    Get dwhmanager Rstate from clearcase    ${dwhmanager_file}
    Connect to server as a dcuser
    ${dwhmanager_rstate_buildno_server}    Get dwhmanager version from server
    Should be equal    ${dwhmanager_rstate_buildno_clearcase}    ${dwhmanager_rstate_buildno_server}

*** Keywords ***
Test Teardown
    Close All Connections