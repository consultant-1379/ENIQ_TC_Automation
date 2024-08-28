*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the twampm module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_twampm}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twampm
    ${platform}=    Remove String Using Regexp    ${grep_twampm}    .*twampm\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twampm
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twampm\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twampm
    ${mws_grep_twampm}=    Remove String Using Regexp    ${mws_path}    .*twampm\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_twampm}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twampm*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twampm_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art twampm* | tail -n 1
    ${twampm}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampm_file}
    Verify the success or skipped msg    ${twampm}    Success    Skipped twampm

*** Keywords ***
Test Teardown
    Close All Connections  