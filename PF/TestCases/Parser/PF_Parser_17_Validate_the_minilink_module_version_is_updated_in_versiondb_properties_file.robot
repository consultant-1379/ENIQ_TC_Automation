*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the minilink module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_minilink}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w minilink
    ${platform}=    Remove String Using Regexp    ${grep_minilink}    .*minilink\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w minilink
    ${Version}=    Remove String Using Regexp    ${version_db}    .*minilink\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^minilink
    ${mws_grep_minilink}=    Remove String Using Regexp    ${mws_path}    .*minilink\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_minilink}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    minilink*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${minilink_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art minilink* | tail -n 1
    ${minilink}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${minilink_file}
    Verify the success or skipped msg    ${minilink}    Success    Skipped minilink

*** Keywords ***
Test Teardown
    Close All Connections    