*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the MDC module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_MDC}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC
    ${platform}=    Remove String Using Regexp    ${grep_MDC}    .*MDC\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_R
    ${mws_grep_MDC}=    Remove String Using Regexp    ${mws_path}    .*MDC\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_MDC}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art MDC* | tail -n 1
    ${MDC}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_file}
    Verify the success or skipped msg    ${MDC}    Success    Skipped MDC

*** Keywords ***
Test Teardown
    Close All Connections    