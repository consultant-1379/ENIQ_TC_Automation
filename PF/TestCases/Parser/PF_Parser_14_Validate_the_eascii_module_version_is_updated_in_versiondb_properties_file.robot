*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the eascii module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_eascii}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w eascii
    ${platform}=    Remove String Using Regexp    ${grep_eascii}    .*eascii\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w eascii
    ${Version}=    Remove String Using Regexp    ${version_db}    .*eascii\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^eascii
    ${mws_grep_eascii}=    Remove String Using Regexp    ${mws_path}    .*eascii\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_eascii}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    eascii*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${eascii_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii 

*** Keywords ***
Test Teardown
    Close All Connections   