*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the twamppt module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_twamppt}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twamppt
    ${platform}=    Remove String Using Regexp    ${grep_twamppt}    .*twamppt\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twamppt
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twamppt\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twamppt
    ${mws_grep_twamppt}=    Remove String Using Regexp    ${mws_path}    .*twamppt\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_twamppt}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twamppt*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twamppt_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art twamppt* | tail -n 1
    ${twamppt}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twamppt_file}
    Verify the success or skipped msg    ${twamppt}    Success    Skipped twamppt

*** Keywords ***
Test Teardown
    Close All Connections  