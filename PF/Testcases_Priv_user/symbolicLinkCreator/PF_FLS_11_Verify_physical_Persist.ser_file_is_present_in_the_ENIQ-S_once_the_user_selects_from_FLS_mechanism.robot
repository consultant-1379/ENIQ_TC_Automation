*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections

*** Test Cases ***
Check physical Persist.ser file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_persist_ser_file}=    Execute Command    ls /eniq/sw/conf/ | grep -i ^Persist.*.ser
    Log To Console    ${fls_persist_ser_file}
    Verify file is present    ${fls_persist_ser_file}   