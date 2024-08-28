*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the MDC_DYN module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_MDC_DYN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC_DYN
    ${platform}=    Remove String Using Regexp    ${grep_MDC_DYN}    .*MDC_DYN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC_DYN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC_DYN\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_DYN
    ${mws_grep_MDC_DYN}=    Remove String Using Regexp    ${mws_path}    .*MDC_DYN\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_MDC_DYN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC_DYN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_DYN_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_DYN* | tail -n 1
    ${MDC_DYN}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_DYN_file}
    Verify the success or skipped msg    ${MDC_DYN}    Success    Skipped MDC_DYN

*** Keywords ***
Test Teardown
    Close All Connections