*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical mixed ser file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_mixed_ser_file}=    Execute Command    ls /eniq/sw/conf/ | grep -i Mixed.*.ser
    Log To Console    ${fls_mixed_ser_file}
    Verify file is present    ${fls_mixed_ser_file}   