*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Validate the asn1 module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_asn1}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w asn1
    ${platform}=    Remove String Using Regexp    ${grep_asn1}    .*asn1\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w asn1
    ${Version}=    Remove String Using Regexp    ${version_db}    .*asn1\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}        
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^asn1
    ${mws_grep_asn1}=    Remove String Using Regexp    ${mws_path}    .*asn1\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_asn1}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    asn1*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${asn1_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art asn1* | tail -n 1
    ${asn1}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${asn1_file}
    Verify the success or skipped msg    ${asn1}    Success    Skipped asn1


*** Keywords ***
Test Teardown
    Close All Connections   