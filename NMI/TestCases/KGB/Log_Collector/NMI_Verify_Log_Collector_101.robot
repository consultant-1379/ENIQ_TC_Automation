*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if log collection has successfully started 
    [Tags]                Log Collector
    ${Content}=           Get File                   Log-Collector.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Collecting logs for

Checking if zip file is created for collected logs
    [Tags]                Log Collector
    ${Content}=           Get File                   Log-Collector.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 ZIP file created

Checking if logs are successfully collected for the deployment
    [Tags]                Log Collector
    ${Content}=           Get File                   Log-Collector.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Successfully collected for
