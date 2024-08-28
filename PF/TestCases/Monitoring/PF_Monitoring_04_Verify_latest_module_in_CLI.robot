*** Settings ***
Documentation     Testing Monitoring
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Monitoring.robot

*** Test Cases ***
Verify latest module in CLI
    ${monitoring_file}    Get the element of monitoring attribute from clearcase
    ${monitoring_rstate_buildno_clearcase}    Get monitoring Rstate from clearcase    ${monitoring_file}
    Connect to server as a dcuser
    ${monitoring_rstate_buildno_server}    Get monitoring version from server
    Should be equal    ${monitoring_rstate_buildno_clearcase}    ${monitoring_rstate_buildno_server}


*** Keywords ***
Test Teardown
    Close All Connections