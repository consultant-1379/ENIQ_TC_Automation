*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical fls conf file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_conf_file}=    Execute Command    ls /eniq/installation/config/ | grep -i fls_conf
    Log To Console    ${fls_conf_file}
    Verify file is present    ${fls_conf_file}   