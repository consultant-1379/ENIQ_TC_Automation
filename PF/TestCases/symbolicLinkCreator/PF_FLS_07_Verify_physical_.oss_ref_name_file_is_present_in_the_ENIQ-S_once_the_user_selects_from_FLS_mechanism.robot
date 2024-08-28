*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical .oss_ref_name_file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_oss_ref_name_file}=    Execute Command    ls -a /eniq/sw/conf | grep -i .oss_ref_name_file
    Log To Console    ${fls_oss_ref_name_file}
    Verify file is present    ${fls_oss_ref_name_file}


    