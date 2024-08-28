*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Validate the HXMLPsIptnms module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_HXMLPsIptnms}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w HXMLPsIptnms
    ${platform}=    Remove String Using Regexp    ${grep_HXMLPsIptnms}    .*HXMLPsIptnms\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w HXMLPsIptnms
    ${Version}=    Remove String Using Regexp    ${version_db}    .*HXMLPsIptnms\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^HXMLPsIptnms
    ${mws_grep_HXMLPsIptnms}=    Remove String Using Regexp    ${mws_path}    .*HXMLPsIptnms\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_HXMLPsIptnms}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    HXMLPsIptnms*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${HXMLPsIptnms_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLPsIptnms* | tail -n 1
    ${HXMLPsIptnms}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLPsIptnms_file}
    Verify the success or skipped msg    ${HXMLPsIptnms}    Success    Skipped HXMLPsIptnms

*** Keywords ***
Test Teardown
    Close All Connections