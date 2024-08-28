*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Validate the xml module version is updated in versiondb.properties file
    ${grep_xml}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w xml
    ${platform}=    Remove String Using Regexp    ${grep_xml}    .*xml\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w xml
    ${Version}=    Remove String Using Regexp    ${version_db}    .*xml\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^xml
    ${mws_grep_xml}=    Remove String Using Regexp    ${mws_path}    .*xml\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_xml}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    xml*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${xml_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art xml* | tail -n 1
    ${xml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${xml_file}
    Verify the success or skipped msg    ${xml}    Success    Skipped xml

*** Keywords ***
Test Teardown
    Close All Connections  