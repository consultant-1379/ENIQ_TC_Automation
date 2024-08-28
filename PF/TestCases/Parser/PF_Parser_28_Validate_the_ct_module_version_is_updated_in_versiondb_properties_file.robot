*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Validate the ct module version is updated in versiondb.properties file
    ${grep_ct}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ct
    ${platform}=    Remove String Using Regexp    ${grep_ct}    .*ct\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ct
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ct\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ct
    ${mws_grep_ct}=    Remove String Using Regexp    ${mws_path}    .*ct\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_ct}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ct*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ct_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ct* | tail -n 1
    ${ct}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ct_file}
    Verify the success or skipped msg    ${ct}    Success    Skipped ct

*** Keywords ***
Test Teardown
    Close All Connections  