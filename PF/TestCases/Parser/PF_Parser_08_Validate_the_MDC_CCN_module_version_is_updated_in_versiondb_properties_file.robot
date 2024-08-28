*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the MDC_CCN module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_MDC_CCN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC_CCN
    ${platform}=    Remove String Using Regexp    ${grep_MDC_CCN}    .*MDC_CCN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC_CCN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC_CCN\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_CCN
    ${mws_grep_MDC_CCN}=    Remove String Using Regexp    ${mws_path}    .*MDC_CCN\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_MDC_CCN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC_CCN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_CCN_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_CCN* | tail -n 1
    ${MDC_CCN}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_CCN_file}
    Verify the success or skipped msg    ${MDC_CCN}    Success    Skipped MDC_CCN

*** Keywords ***
Test Teardown
    Close All Connections