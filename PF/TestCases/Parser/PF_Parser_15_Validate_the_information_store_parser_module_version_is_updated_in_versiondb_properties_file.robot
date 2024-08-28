*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the information_store_parser module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_information_store_parser}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w information_store_parser
    ${platform}=    Remove String Using Regexp    ${grep_information_store_parser}    .*information_store_parser\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w information_store_parser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*information_store_parser\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^information_store_parser
    ${mws_grep_information_store_parser}=    Remove String Using Regexp    ${mws_path}    .*information_store_parser\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_information_store_parser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    information_store_parser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${information_store_parser_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art information_store_parser* | tail -n 1
    ${information_store_parser}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${information_store_parser_file}
    Verify the success or skipped msg    ${information_store_parser}    Success    Skipped information_store_parser

*** Keywords ***
Test Teardown
    Close All Connections    