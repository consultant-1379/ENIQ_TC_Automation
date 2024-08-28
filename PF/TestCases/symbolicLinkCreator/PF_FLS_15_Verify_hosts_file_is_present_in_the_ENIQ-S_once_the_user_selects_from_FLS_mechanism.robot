*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify hosts file is present in the ENIQ-S once the user selects from FLS mechanism
    ${check_fls_conf_file}=    Execute Command    ls /etc/ | grep ^hosts$
    Log To Console    ${check_fls_conf_file}
    Verify file is present    ${check_fls_conf_file}   