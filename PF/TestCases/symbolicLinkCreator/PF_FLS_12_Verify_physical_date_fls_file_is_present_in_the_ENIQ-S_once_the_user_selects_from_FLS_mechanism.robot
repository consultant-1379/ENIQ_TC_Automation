*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical date fls file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_date_fls_file}=    Execute Command    ls /eniq/sw/conf/ | grep -i ^date_fls.*
    Log To Console    ${fls_date_fls_file}
    Verify file is present    ${fls_date_fls_file}   