*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the kpiparser module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_kpiparser}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w kpiparser
    ${platform}=    Remove String Using Regexp    ${grep_kpiparser}    .*kpiparser\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w kpiparser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*kpiparser\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^kpiparser
    ${mws_grep_kpiparser}=    Remove String Using Regexp    ${mws_path}    .*kpiparser\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_kpiparser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    kpiparser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${kpiparser_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art kpiparser* | tail -n 1
    ${kpiparser}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${kpiparser_file}
    Verify the success or skipped msg    ${kpiparser}    Success    Skipped kpiparser

*** Keywords ***
Test Teardown
    Close All Connections    