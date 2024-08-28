*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical service_names file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_service_names_file}=    Execute Command    ls /eniq/sw/conf/ | grep service_names
    Log To Console    ${fls_service_names_file}
    Verify file is present    ${fls_service_names_file}   