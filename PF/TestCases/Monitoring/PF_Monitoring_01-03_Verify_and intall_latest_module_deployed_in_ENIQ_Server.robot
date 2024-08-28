*** Settings ***
Documentation     Testing Monitoring
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Monitoring.robot
Suite Setup    Connection to physical server
Suite Teardown    Close All Connections

*** Test Cases ***
Verify and intall the latest module deployed in ENIQ_server
    ${Monitoring_file}    Get the element of Monitoring attribute from clearcase
    ${Monitoring_rstate_buildno_clearcase}    Get Monitoring Rstate from clearcase    ${Monitoring_file}
    Connection to physical server
    ${Monitoring_rstate_buildno_server}    Get Monitoring version from server
    ${rstate_status}    Verify the latest Monitoring version is updated in versiondb.properties file    ${Monitoring_rstate_buildno_clearcase}    ${Monitoring_rstate_buildno_server}
    Set Global Variable    ${rstate_status}
    Verify the installation of latest Monitoring package

*** Keywords ***
Test Teardown
    Close All Connections