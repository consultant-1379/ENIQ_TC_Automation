*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Validate the volte module version is updated in versiondb.properties file
    ${grep_volte}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w volte
    ${platform}=    Remove String Using Regexp    ${grep_volte}    .*volte\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w volte
    ${Version}=    Remove String Using Regexp    ${version_db}    .*volte\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^volte
    ${mws_grep_volte}=    Remove String Using Regexp    ${mws_path}    .*volte\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_volte}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    volte*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${volte_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art volte* | tail -n 1
    ${volte}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${volte_file}
    Verify the success or skipped msg    ${volte}    Success    Skipped volte

*** Keywords ***
Test Teardown
    Close All Connections  