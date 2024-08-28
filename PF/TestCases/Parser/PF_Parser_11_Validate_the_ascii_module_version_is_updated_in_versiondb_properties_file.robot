*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the ascii module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_ascii}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ascii
    ${platform}=    Remove String Using Regexp    ${grep_ascii}    .*ascii\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ascii
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ascii\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ascii
    ${mws_grep_ascii}=    Remove String Using Regexp    ${mws_path}    .*ascii\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_ascii}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ascii*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ascii_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ascii* | tail -n 1
    ${ascii}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ascii_file}
    Verify the success or skipped msg    ${ascii}    Success    Skipped ascii

*** Keywords ***
Test Teardown
    Close All Connections    