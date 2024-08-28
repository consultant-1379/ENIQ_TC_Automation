*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if logs are being zipped and transferred
    [Tags]                Log Collector
    ${Content}=           Get File                   Log-Transfer.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 sftp> put

Checking if logs are being uploaded to destination server
    [Tags]                Log Collector
    ${Content}=           Get File                   Log-Transfer.log
    Set Global Variable   ${Content}
    Should Contain        ${Content}                 Uploading
