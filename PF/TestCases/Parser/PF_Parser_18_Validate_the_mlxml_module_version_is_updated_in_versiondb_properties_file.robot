*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the mlxml module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_mlxml}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w mlxml
    ${platform}=    Remove String Using Regexp    ${grep_mlxml}    .*mlxml\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w mlxml
    ${Version}=    Remove String Using Regexp    ${version_db}    .*mlxml\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^mlxml
    ${mws_grep_mlxml}=    Remove String Using Regexp    ${mws_path}    .*mlxml\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_mlxml}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    mlxml*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${mlxml_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art mlxml* | tail -n 1
    ${mlxml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${mlxml_file}
    Verify the success or skipped msg    ${mlxml}    Success    Skipped mlxml

*** Keywords ***
Test Teardown
    Close All Connections  