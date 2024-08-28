*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the twampst module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_twampst}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twampst
    ${platform}=    Remove String Using Regexp    ${grep_twampst}    .*twampst\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twampst
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twampst\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twampst
    ${mws_grep_twampst}=    Remove String Using Regexp    ${mws_path}    .*twampst\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_twampst}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twampst*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twampst_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art twampst* | tail -n 1
    ${twampst}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampst_file}
    Verify the success or skipped msg    ${twampst}    Success    Skipped twampst

*** Keywords ***
Test Teardown
    Close All Connections  