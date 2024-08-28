*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Validate the stfiop module version is updated in versiondb.properties file
    ${grep_stfiop}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w stfiop
    ${platform}=    Remove String Using Regexp    ${grep_stfiop}    .*stfiop\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w stfiop
    ${Version}=    Remove String Using Regexp    ${version_db}    .*stfiop\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^stfiop
    ${mws_grep_stfiop}=    Remove String Using Regexp    ${mws_path}    .*stfiop\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_stfiop}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    stfiop*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${stfiop_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art stfiop* | tail -n 1
    ${stfiop}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${stfiop_file}
    Verify the success or skipped msg    ${stfiop}    Success    Skipped stfiop

*** Keywords ***
Test Teardown
    Close All Connections 