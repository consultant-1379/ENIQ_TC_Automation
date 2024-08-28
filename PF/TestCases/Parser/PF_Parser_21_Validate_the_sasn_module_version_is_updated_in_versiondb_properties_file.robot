*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the sasn module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_sasn}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w sasn
    ${platform}=    Remove String Using Regexp    ${grep_sasn}    .*sasn\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w sasn
    ${Version}=    Remove String Using Regexp    ${version_db}    .*sasn\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^sasn
    ${mws_grep_sasn}=    Remove String Using Regexp    ${mws_path}    .*sasn\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_sasn}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    sasn*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${sasn_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art sasn* | tail -n 1
    ${sasn}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${sasn_file}
    Verify the success or skipped msg    ${sasn}    Success    Skipped sasn

*** Keywords ***
Test Teardown
    Close All Connections  