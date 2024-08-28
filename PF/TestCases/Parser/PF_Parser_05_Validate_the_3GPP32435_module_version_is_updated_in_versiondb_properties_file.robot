*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Validate the 3GPP32435 module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_3GPP32435}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435 
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435}    .*3GPP32435\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435\\S
    Verify the R Version db properties in platform path    ${Version}    ${platform}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435_
    ${mws_grep_3GPP32435}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_3GPP32435}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435* | tail -n 1
    ${3GPP32435}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435_file}
    Verify the success or skipped msg    ${3GPP32435}    Success    Skipped 3GPP32435

*** Keywords ***
Test Teardown
    Close All Connections    