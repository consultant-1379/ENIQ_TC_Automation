*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for fls_oss_integration_mode file in OSS Source TC01
    [Documentation]          Checking for fls_oss_integration_mode.json file in /eniq/log/assureddc/file_lookup_service directory
    [Tags]                   OSS_Integration_Information
    ${oss_output_var}=       Run Keyword And Return Status     Check File Exists     /eniq/log/assureddc/file_lookup_service/fls_oss_integration_mode.json
    Set Global Variable      ${oss_output_var}
    Run Keyword If           ${oss_output_var} == False    Skip    fls_oss_integration_mode file is not there in the source path

Checking for fls_oss_integration_mode file size in OSS Source TC02
    Skip If    ${oss_output_var} == False
    Depends on test       Checking for fls_oss_integration_mode file in OSS Source TC01
    [Documentation]       Checking for fls_oss_integration_mode.json file in /eniq/log/assureddc/file_lookup_service directory
    [Tags]                OSS_Integration_Information
    Check File Size       /eniq/log/assureddc/file_lookup_service/fls_oss_integration_mode.json

Checking for fls_oss_integration_mode file in OSS destination TC03
    Skip If    ${oss_output_var} == False
    Depends on test       Checking for fls_oss_integration_mode file size in OSS Source TC02
    [Documentation]       Checking for fls_oss_integration_mode_${date_Y-m-d} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/file_lookup_service directory
    [Tags]                OSS_Integration_Information
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/file_lookup_service/fls_oss_integration_mode.json

Checking for fls_oss_integration_mode file size in OSS destination TC04
    Skip If    ${oss_output_var} == False
    Depends on test       Checking for fls_oss_integration_mode file in OSS destination TC03
    [Documentation]       Checking for non empty fls_oss_integration_mode_${date_Y-m-d} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/file_lookup_service directory
    [Tags]                OSS_Integration_Information
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/file_lookup_service/fls_oss_integration_mode.json
