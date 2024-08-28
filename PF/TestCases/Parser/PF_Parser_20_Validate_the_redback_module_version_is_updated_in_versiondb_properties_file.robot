*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Validate the redback module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_redback}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w redback
    ${platform}=    Remove String Using Regexp    ${grep_redback}    .*redback\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w redback
    ${Version}=    Remove String Using Regexp    ${version_db}    .*redback\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^redback
    ${mws_grep_redback}=    Remove String Using Regexp    ${mws_path}    .*redback\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_redback}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    redback*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${redback_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art redback* | tail -n 1
    ${redback}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${redback_file}
    Verify the success or skipped msg    ${redback}    Success    Skipped redback

*** Keywords ***
Test Teardown
    Close All Connections  