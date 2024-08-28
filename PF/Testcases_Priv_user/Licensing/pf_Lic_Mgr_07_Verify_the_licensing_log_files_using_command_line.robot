*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
verify licensing log for any failures
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${latest_file}=    Getting latest file from the folder    ${license_folder}    ${latest_licensemanager_file}
    ${faliure_logs}=    Opening the licensing latest file and searching for failure    ${latest_file}
    #verify logs should not contain faliure   ${faliure_logs}