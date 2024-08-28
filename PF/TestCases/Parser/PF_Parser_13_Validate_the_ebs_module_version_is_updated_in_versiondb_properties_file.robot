*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the ebs module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_ebs}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ebs
    ${platform}=    Remove String Using Regexp    ${grep_ebs}    .*ebs\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ebs
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ebs\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}    
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ebs
    ${mws_grep_ebs}=    Remove String Using Regexp    ${mws_path}    .*ebs\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_ebs}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ebs*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ebs_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs

*** Keywords ***
Test Teardown
    Close All Connections    