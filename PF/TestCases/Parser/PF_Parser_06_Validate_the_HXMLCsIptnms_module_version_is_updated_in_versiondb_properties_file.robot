*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the HXMLCsIptnms module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_HXMLCsIptnms}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w HXMLCsIptnms
    ${platform}=    Remove String Using Regexp    ${grep_HXMLCsIptnms}    .*HXMLCsIptnms\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w HXMLCsIptnms
    ${Version}=    Remove String Using Regexp    ${version_db}    .*HXMLCsIptnms\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^HXMLCsIptnms
    ${mws_grep_HXMLCsIptnms}=    Remove String Using Regexp    ${mws_path}    .*HXMLCsIptnms\\S    .zip
    Verify the R Version db properties in MWS path    ${Version}    ${mws_grep_HXMLCsIptnms}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    HXMLCsIptnms*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${HXMLCsIptnms_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLCsIptnms* | tail -n 1
    ${HXMLCsIptnms}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLCsIptnms_file}
    Verify the success or skipped msg    ${HXMLCsIptnms}    Success    Skipped HXMLCsIptnms

*** Keywords ***
Test Teardown
    Close All Connections