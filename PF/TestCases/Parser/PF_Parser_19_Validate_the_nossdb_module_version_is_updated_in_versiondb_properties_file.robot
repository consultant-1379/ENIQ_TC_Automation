*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the nossdb module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_nossdb}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w nossdb
    ${platform}=    Remove String Using Regexp    ${grep_nossdb}    .*nossdb\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w nossdb
    ${Version}=    Remove String Using Regexp    ${version_db}    .*nossdb\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^nossdb
    ${mws_grep_nossdb}=    Remove String Using Regexp    ${mws_path}    .*nossdb\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_nossdb}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    nossdb*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${nossdb_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art nossdb* | tail -n 1
    ${nossdb}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${nossdb_file}
    Verify the success or skipped msg    ${nossdb}    Success    Skipped nossdb


*** Keywords ***
Test Teardown
    Close All Connections  