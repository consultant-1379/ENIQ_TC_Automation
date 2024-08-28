*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Validate the parser module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_parser}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w parser
    ${platform}=    Remove String Using Regexp    ${grep_parser}    .*parser\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w parser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*parser\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^parser
    ${mws_grep_parser}=    Remove String Using Regexp    ${mws_path}    .*parser\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_parser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    parser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${parser}=    Execute the command    ${install_parser_success_msg}
    Verify the msg    ${parser}    Completed installing parser

*** Keywords ***
Test Teardown
    Close All Connections      

