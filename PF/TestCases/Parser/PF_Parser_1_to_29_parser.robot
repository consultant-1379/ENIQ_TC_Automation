*** Settings ***
Library             SSHLibrary
Library             String
Library             Collections
Resource            ../../Resources/Keywords/Parser.robot
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot

Test Setup          Open connection as root user
Test Teardown       Close All Connections


*** Test Cases ***
TC 01 Verify installed parser modules folders are available in /eniq/sw/platform path
    Open connection as root user
    ${platform}=    Execute Command    find /eniq/sw/platform/ -type f -name "*.zip" -printf "%f\n"
    @{pf_dir_list}=    Split To Lines    ${platform}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_dir_files}=    Execute Command
    ...    ${mws_path_list_of_modules}${Features}/eniq_parsers/; find -type f -name "*.zip" -printf "%f\n"
    @{mws_dir_list}=    Split To Lines    ${mws_dir_files}
    List Should Contain Sub List    ${pf_dir_list}    ${mws_dir_list}
    Execute the command    ${platform_installer}
    ${latest_file_parser}=    Get latest file from directory    parser*
    ${latest_file_3GPP32435}=    Get latest file from directory    3GPP32435*
    ${latest_file_3GPP32435BCS}=    Get latest file from directory    3GPP32435BCS*
    ${latest_file_3GPP32435DYN}=    Get latest file from directory    3GPP32435DYN*
    ${latest_file_HXMLCsIptnms}=    Get latest file from directory    HXMLCsIptnms*
    ${latest_file_HXMLPsIptnms}=    Get latest file from directory    HXMLPsIptnms*
    ${latest_file_MDC}=    Get latest file from directory    MDC*
    ${latest_file_MDC_CCN}=    Get latest file from directory    MDC_CCN*
    ${latest_file_MDC_PC}=    Get latest file from directory    MDC_PC*
    ${latest_file_TCIMParser}=    Get latest file from directory    TCIMParser*
    ${latest_file_ascii}=    Get latest file from directory    ascii*
    ${latest_file_asn1}=    Get latest file from directory    asn1*
    ${latest_file_bcd}=    Get latest file from directory    bcd*
    ${latest_file_nossdb}=    Get latest file from directory    nossdb*
    ${latest_file_mrr}=    Get latest file from directory    mrr*
    ${latest_file_mlxml}=    Get latest file from directory    mlxml*
    ${latest_file_minilink}=    Get latest file from directory    minilink*
    ${latest_file_ct}=    Get latest file from directory    ct*
    ${latest_file_redback}=    Get latest file from directory    redback*
    ${latest_file_sasn}=    Get latest file from directory    sasn*
    ${latest_file_twampm}=    Get latest file from directory    twampm*
    ${latest_file_twamppt}=    Get latest file from directory    twamppt*
    ${latest_file_twampst}=    Get latest file from directory    twampst*
    ${latest_file_volte}=    Get latest file from directory    volte*
    ${latest_file_csexport}=    Get latest file from directory    csexport*
    ${latest_file_ebs}=    Get latest file from directory    ebs*
    ${latest_file_eascii}=    Get latest file from directory    eascii*
    ${latest_file_xml}=    Get latest file from directory    xml*
    ${latest_file_json}=    Get latest file from directory    json*
    ${latest_file_stfiop}=    Get latest file from directory    stfiop*

    # Negative Scenario 0 arg, like error, warning, exception, failed
    # Positive Scenario 1 arg, like Success, created, passed
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_parser}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_3GPP32435}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_3GPP32435BCS}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_3GPP32435DYN}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_HXMLCsIptnms}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_HXMLPsIptnms}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_MDC}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_MDC_CCN}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_MDC_PC}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_TCIMParser}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_ascii}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_asn1}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_bcd}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_nossdb}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_mrr}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_mlxml}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_minilink}
    ...    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_ct}    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_redback}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_sasn}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_twampm}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_twamppt}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_twampst}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_volte}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_csexport}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_ebs}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_eascii}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_xml}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_json}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_stfiop}
    ...    0
    ${parser}=    Execute the command    ${install_parser_success_msg}
    Verify the msg    ${parser}    Completed installing parser
    ${3GPP32435BCS_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435BCS* | tail -n 1
    ${3GPP32435BCS}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435BCS_file}
    Verify the success or skipped msg    ${3GPP32435BCS}    Success    Skipped 3GPP32435BCS
    ${3GPP32435DYN_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435DYN* | tail -n 1
    ${3GPP32435DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435DYN_file}
    Verify the success or skipped msg    ${3GPP32435DYN}    Success    Skipped 3GPP32435DYN
    ${3GPP32435_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435* | tail -n 1
    ${3GPP32435}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435_file}
    Verify the success or skipped msg    ${3GPP32435}    Success    Skipped 3GPP32435
    ${HXMLCsIptnms_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLCsIptnms* | tail -n 1
    ${HXMLCsIptnms}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLCsIptnms_file}
    Verify the success or skipped msg    ${HXMLCsIptnms}    Success    Skipped HXMLCsIptnms
    ${HXMLPsIptnms_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLPsIptnms* | tail -n 1
    ${HXMLPsIptnms}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLPsIptnms_file}
    Verify the success or skipped msg    ${HXMLPsIptnms}    Success    Skipped HXMLPsIptnms
    ${MDC_CCN_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_CCN* | tail -n 1
    ${MDC_CCN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_CCN_file}
    Verify the success or skipped msg    ${MDC_CCN}    Success    Skipped MDC_CCN
    ${MDC_DYN_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_DYN* | tail -n 1
    ${MDC_DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_DYN_file}
    Verify the success or skipped msg    ${MDC_DYN}    Success    Skipped MDC_DYN
    ${MDC_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC* | tail -n 1
    ${MDC}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_file}
    Verify the success or skipped msg    ${MDC}    Success    Skipped MDC
    ${ascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ascii* | tail -n 1
    ${ascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ascii_file}
    Verify the success or skipped msg    ${ascii}    Success    Skipped ascii
    ${asn1_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art asn1* | tail -n 1
    ${asn1}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${asn1_file}
    Verify the success or skipped msg    ${asn1}    Success    Skipped asn1
    ${ebs_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs
    ${eascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii
    ${information_store_parser_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art information_store_parser* | tail -n 1
    ${information_store_parser}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${information_store_parser_file}
    Verify the success or skipped msg    ${information_store_parser}    Success    Skipped information_store_parser
    ${kpiparser_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art kpiparser* | tail -n 1
    ${kpiparser}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${kpiparser_file}
    Verify the success or skipped msg    ${kpiparser}    Success    Skipped kpiparser
    ${mlxml_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art mlxml* | tail -n 1
    ${mlxml}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${mlxml_file}
    Verify the success or skipped msg    ${mlxml}    Success    Skipped mlxml
    ${minilink_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art minilink* | tail -n 1
    ${minilink}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${minilink_file}
    Verify the success or skipped msg    ${minilink}    Success    Skipped minilink
    ${nossdb_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art nossdb* | tail -n 1
    ${nossdb}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${nossdb_file}
    Verify the success or skipped msg    ${nossdb}    Success    Skipped nossdb
    ${redback_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art redback* | tail -n 1
    ${redback}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${redback_file}
    Verify the success or skipped msg    ${redback}    Success    Skipped redback
    ${sasn_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art sasn* | tail -n 1
    ${sasn}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${sasn_file}
    Verify the success or skipped msg    ${sasn}    Success    Skipped sasn
    ${twampm_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twampm* | tail -n 1
    ${twampm}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampm_file}
    Verify the success or skipped msg    ${twampm}    Success    Skipped twampm
    ${twamppt_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twamppt* | tail -n 1
    ${twamppt}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twamppt_file}
    Verify the success or skipped msg    ${twamppt}    Success    Skipped twamppt
    ${twampst_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twampst* | tail -n 1
    ${twampst}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampst_file}
    Verify the success or skipped msg    ${twampst}    Success    Skipped twampst
    ${volte_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art volte* | tail -n 1
    ${volte}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${volte_file}
    Verify the success or skipped msg    ${volte}    Success    Skipped volte
    ${csexport_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art csexport* | tail -n 1
    ${csexport}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${csexport_file}
    Verify the success or skipped msg    ${csexport}    Success    Skipped csexport
    ${ebs_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs
    ${eascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii
    ${xml_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art xml* | tail -n 1
    ${xml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${xml_file}
    Verify the success or skipped msg    ${xml}    Success    Skipped xml
    ${ct_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ct* | tail -n 1
    ${ct}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ct_file}
    Verify the success or skipped msg    ${ct}    Success    Skipped ct
    ${stfiop_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art stfiop* | tail -n 1
    ${stfiop}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${stfiop_file}
    Verify the success or skipped msg    ${stfiop}    Success    Skipped stfiop

TC 02 Validate the parser module version is updated in versiondb.properties file
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

TC 03 Validate the 3GPP32435BCS module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_3GPP32435BC}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435BCS
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435BC}    .*3GPP32435BCS\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435BCS
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435BCS\\S
    Verify the R Version db properties in platform path    ${Version}    ${platform}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435BCS
    ${mws_grep_3GPP32435BC}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435BCS\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_3GPP32435BC}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435BCS*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435BCS_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435BCS* | tail -n 1
    ${3GPP32435BCS}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435BCS_file}
    Verify the success or skipped msg    ${3GPP32435BCS}    Success    Skipped 3GPP32435BCS

TC 04 Validate the 3GPP32435DYN module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_3GPP32435DYN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435DYN
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435DYN}    .*3GPP32435DYN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435DYN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435DYN\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435DYN
    ${mws_grep_3GPP32435DYN}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435DYN\\S    .zip
    Verify the R Version db properties in MWS path    ${Version}    ${mws_grep_3GPP32435DYN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435DYN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435DYN_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435DYN* | tail -n 1
    ${3GPP32435DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435DYN_file}
    Verify the success or skipped msg    ${3GPP32435DYN}    Success    Skipped 3GPP32435DYN

TC 05 Validate the 3GPP32435 module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_3GPP32435}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435}    .*3GPP32435\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435\\S
    Verify the R Version db properties in platform path    ${Version}    ${platform}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435_
    ${mws_grep_3GPP32435}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_3GPP32435}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435* | tail -n 1
    ${3GPP32435}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435_file}
    Verify the success or skipped msg    ${3GPP32435}    Success    Skipped 3GPP32435

TC 06 Validate the HXMLCsIptnms module version is updated in versiondb.properties file
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
    ${HXMLCsIptnms_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLCsIptnms* | tail -n 1
    ${HXMLCsIptnms}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLCsIptnms_file}
    Verify the success or skipped msg    ${HXMLCsIptnms}    Success    Skipped HXMLCsIptnms

TC 07 Validate the HXMLPsIptnms module version is updated in versiondb.properties file
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


TC 08 Validate the MDC_CCN module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_MDC_CCN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC_CCN
    ${platform}=    Remove String Using Regexp    ${grep_MDC_CCN}    .*MDC_CCN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC_CCN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC_CCN\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_CCN
    ${mws_grep_MDC_CCN}=    Remove String Using Regexp    ${mws_path}    .*MDC_CCN\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_MDC_CCN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC_CCN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_CCN_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_CCN* | tail -n 1
    ${MDC_CCN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_CCN_file}
    Verify the success or skipped msg    ${MDC_CCN}    Success    Skipped MDC_CCN

TC 09 Validate the MDC_DYN module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_MDC_DYN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC_DYN
    ${platform}=    Remove String Using Regexp    ${grep_MDC_DYN}    .*MDC_DYN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC_DYN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC_DYN\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_DYN
    ${mws_grep_MDC_DYN}=    Remove String Using Regexp    ${mws_path}    .*MDC_DYN\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_MDC_DYN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC_DYN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_DYN_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_DYN* | tail -n 1
    ${MDC_DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_DYN_file}
    Verify the success or skipped msg    ${MDC_DYN}    Success    Skipped MDC_DYN

TC 10 Validate the MDC module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_MDC}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC
    ${platform}=    Remove String Using Regexp    ${grep_MDC}    .*MDC\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_R
    ${mws_grep_MDC}=    Remove String Using Regexp    ${mws_path}    .*MDC\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_MDC}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC* | tail -n 1
    ${MDC}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_file}
    Verify the success or skipped msg    ${MDC}    Success    Skipped MDC

TC 11 Validate the ascii module version is updated in versiondb.properties file
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
    ${ascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ascii* | tail -n 1
    ${ascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ascii_file}
    Verify the success or skipped msg    ${ascii}    Success    Skipped ascii

TC 12 Validate the asn1 module version is updated in versiondb.properties file
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
    ${asn1_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art asn1* | tail -n 1
    ${asn1}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${asn1_file}
    Verify the success or skipped msg    ${asn1}    Success    Skipped asn1

TC 13 Validate the ebs module version is updated in versiondb.properties file
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
    ${ebs_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs

TC 14 Validate the eascii module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_eascii}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w eascii
    ${platform}=    Remove String Using Regexp    ${grep_eascii}    .*eascii\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w eascii
    ${Version}=    Remove String Using Regexp    ${version_db}    .*eascii\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^eascii
    ${mws_grep_eascii}=    Remove String Using Regexp    ${mws_path}    .*eascii\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_eascii}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    eascii*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${eascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii

TC 15 Validate the information_store_parser module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_information_store_parser}=    Execute Command
    ...    cd /eniq/sw/platform ; ls | grep -w information_store_parser
    ${platform}=    Remove String Using Regexp    ${grep_information_store_parser}    .*information_store_parser\\S
    ${version_db}=    Execute Command
    ...    cd /eniq/sw/installer ; cat versiondb.properties | grep -w information_store_parser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*information_store_parser\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command
    ...    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^information_store_parser
    ${mws_grep_information_store_parser}=    Remove String Using Regexp
    ...    ${mws_path}
    ...    .*information_store_parser\\S
    ...    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_information_store_parser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    information_store_parser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${information_store_parser_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art information_store_parser* | tail -n 1
    ${information_store_parser}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${information_store_parser_file}
    Verify the success or skipped msg    ${information_store_parser}    Success    Skipped information_store_parser

Tc 16 Validate the kpiparser module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_kpiparser}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w kpiparser
    ${platform}=    Remove String Using Regexp    ${grep_kpiparser}    .*kpiparser\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w kpiparser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*kpiparser\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^kpiparser
    ${mws_grep_kpiparser}=    Remove String Using Regexp    ${mws_path}    .*kpiparser\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_kpiparser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    kpiparser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${kpiparser_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art kpiparser* | tail -n 1
    ${kpiparser}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${kpiparser_file}
    Verify the success or skipped msg    ${kpiparser}    Success    Skipped kpiparser

TC 17 Validate the minilink module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_minilink}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w minilink
    ${platform}=    Remove String Using Regexp    ${grep_minilink}    .*minilink\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w minilink
    ${Version}=    Remove String Using Regexp    ${version_db}    .*minilink\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^minilink
    ${mws_grep_minilink}=    Remove String Using Regexp    ${mws_path}    .*minilink\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_minilink}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    minilink*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${minilink_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art minilink* | tail -n 1
    ${minilink}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${minilink_file}
    Verify the success or skipped msg    ${minilink}    Success    Skipped minilink

TC 18 Validate the mlxml module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_mlxml}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w mlxml
    ${platform}=    Remove String Using Regexp    ${grep_mlxml}    .*mlxml\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w mlxml
    ${Version}=    Remove String Using Regexp    ${version_db}    .*mlxml\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^mlxml
    ${mws_grep_mlxml}=    Remove String Using Regexp    ${mws_path}    .*mlxml\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_mlxml}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    mlxml*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${mlxml_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art mlxml* | tail -n 1
    ${mlxml}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${mlxml_file}
    Verify the success or skipped msg    ${mlxml}    Success    Skipped mlxml

TC 19 Validate the nossdb module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_nossdb}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w nossdb
    ${platform}=    Remove String Using Regexp    ${grep_nossdb}    .*nossdb\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w nossdb
    ${Version}=    Remove String Using Regexp    ${version_db}    .*nossdb\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^nossdb
    ${mws_grep_nossdb}=    Remove String Using Regexp    ${mws_path}    .*nossdb\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_nossdb}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    nossdb*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${nossdb_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art nossdb* | tail -n 1
    ${nossdb}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${nossdb_file}
    Verify the success or skipped msg    ${nossdb}    Success    Skipped nossdb

TC 20 Validate the redback module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_redback}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w redback
    ${platform}=    Remove String Using Regexp    ${grep_redback}    .*redback\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w redback
    ${Version}=    Remove String Using Regexp    ${version_db}    .*redback\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^redback
    ${mws_grep_redback}=    Remove String Using Regexp    ${mws_path}    .*redback\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_redback}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    redback*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${redback_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art redback* | tail -n 1
    ${redback}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${redback_file}
    Verify the success or skipped msg    ${redback}    Success    Skipped redback

TC 21 Validate the sasn module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_sasn}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w sasn
    ${platform}=    Remove String Using Regexp    ${grep_sasn}    .*sasn\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w sasn
    ${Version}=    Remove String Using Regexp    ${version_db}    .*sasn\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^sasn
    ${mws_grep_sasn}=    Remove String Using Regexp    ${mws_path}    .*sasn\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_sasn}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    sasn*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${sasn_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art sasn* | tail -n 1
    ${sasn}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${sasn_file}
    Verify the success or skipped msg    ${sasn}    Success    Skipped sasn

TC 22 Validate the stfiop module version is updated in versiondb.properties file
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
    ${stfiop_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art stfiop* | tail -n 1
    ${stfiop}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${stfiop_file}
    Verify the success or skipped msg    ${stfiop}    Success    Skipped stfiop

TC 23 Validate the twampm module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_twampm}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twampm
    ${platform}=    Remove String Using Regexp    ${grep_twampm}    .*twampm\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twampm
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twampm\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twampm
    ${mws_grep_twampm}=    Remove String Using Regexp    ${mws_path}    .*twampm\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_twampm}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twampm*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twampm_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twampm* | tail -n 1
    ${twampm}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampm_file}
    Verify the success or skipped msg    ${twampm}    Success    Skipped twampm

TC 24 Validate the twamppt module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_twamppt}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twamppt
    ${platform}=    Remove String Using Regexp    ${grep_twamppt}    .*twamppt\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twamppt
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twamppt\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twamppt
    ${mws_grep_twamppt}=    Remove String Using Regexp    ${mws_path}    .*twamppt\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_twamppt}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twamppt*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twamppt_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twamppt* | tail -n 1
    ${twamppt}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twamppt_file}
    Verify the success or skipped msg    ${twamppt}    Success    Skipped twamppt

TC 25 Validate the twampst module version is updated in versiondb.properties file
    Open connection as root user
    ${grep_twampst}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twampst
    ${platform}=    Remove String Using Regexp    ${grep_twampst}    .*twampst\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twampst
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twampst\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twampst
    ${mws_grep_twampst}=    Remove String Using Regexp    ${mws_path}    .*twampst\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_twampst}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twampst*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twampst_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twampst* | tail -n 1
    ${twampst}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampst_file}
    Verify the success or skipped msg    ${twampst}    Success    Skipped twampst

TC 26 Validate the volte module version is updated in versiondb.properties file
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
    ${volte_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art volte* | tail -n 1
    ${volte}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${volte_file}
    Verify the success or skipped msg    ${volte}    Success    Skipped volte

TC 27 Validate the xml module version is updated in versiondb.properties file
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
    ${xml_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art xml* | tail -n 1
    ${xml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${xml_file}
    Verify the success or skipped msg    ${xml}    Success    Skipped xml

TC 28 Validate the ct module version is updated in versiondb.properties file
    ${grep_ct}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ct
    ${platform}=    Remove String Using Regexp    ${grep_ct}    .*ct\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ct
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ct\\S
    Verify the R Version db properties in platform path    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ct
    ${mws_grep_ct}=    Remove String Using Regexp    ${mws_path}    .*ct\\S    .zip
    Verify the R Version db properties in MWS path    ${platform}    ${mws_grep_ct}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ct*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ct_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ct* | tail -n 1
    ${ct}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ct_file}
    Verify the success or skipped msg    ${ct}    Success    Skipped ct

TC 29 Verify the engine logs of All parser modules
    Execute the command    ${platform_installer}
    FOR    ${element}    IN    @{all_modules}
        Execute the command    ls | grep -i ${element}
    END
    ${latest_file_parser}=    Get latest file from directory    parser*
    ${latest_file_3GPP32435}=    Get latest file from directory    3GPP32435*
    ${latest_file_3GPP32435BCS}=    Get latest file from directory    3GPP32435BCS*
    ${latest_file_3GPP32435DYN}=    Get latest file from directory    3GPP32435DYN*
    ${latest_file_HXMLCsIptnms}=    Get latest file from directory    HXMLCsIptnms*
    ${latest_file_HXMLPsIptnms}=    Get latest file from directory    HXMLPsIptnms*
    ${latest_file_MDC}=    Get latest file from directory    MDC*
    ${latest_file_MDC_CCN}=    Get latest file from directory    MDC_CCN*
    ${latest_file_MDC_PC}=    Get latest file from directory    MDC_PC*
    ${latest_file_TCIMParser}=    Get latest file from directory    TCIMParser*
    ${latest_file_ascii}=    Get latest file from directory    ascii*
    ${latest_file_asn1}=    Get latest file from directory    asn1*
    ${latest_file_bcd}=    Get latest file from directory    bcd*
    ${latest_file_nossdb}=    Get latest file from directory    nossdb*
    ${latest_file_mrr}=    Get latest file from directory    mrr*
    ${latest_file_mlxml}=    Get latest file from directory    mlxml*
    ${latest_file_minilink}=    Get latest file from directory    minilink*
    ${latest_file_ct}=    Get latest file from directory    ct*
    ${latest_file_redback}=    Get latest file from directory    redback*
    ${latest_file_sasn}=    Get latest file from directory    sasn*
    ${latest_file_twampm}=    Get latest file from directory    twampm*
    ${latest_file_twamppt}=    Get latest file from directory    twamppt*
    ${latest_file_twampst}=    Get latest file from directory    twampst*
    ${latest_file_volte}=    Get latest file from directory    volte*
    ${latest_file_csexport}=    Get latest file from directory    csexport*
    ${latest_file_ebs}=    Get latest file from directory    ebs*
    ${latest_file_eascii}=    Get latest file from directory    eascii*
    ${latest_file_xml}=    Get latest file from directory    xml*
    ${latest_file_json}=    Get latest file from directory    json*
    ${latest_file_stfiop}=    Get latest file from directory    stfiop*
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_parser}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_3GPP32435}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_3GPP32435BCS}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_3GPP32435DYN}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_HXMLCsIptnms}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_HXMLPsIptnms}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_MDC}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_MDC_CCN}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_MDC_PC}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_TCIMParser}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_ascii}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_asn1}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_bcd}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_nossdb}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_mrr}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_mlxml}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_minilink}
    ...    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_ct}    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_redback}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_sasn}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_twampm}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_twamppt}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_twampst}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_volte}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_csexport}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_ebs}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_eascii}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_xml}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_json}
    ...    0
    Validate the log file for
    ...    ${no_error_warning_execption_failed_notfound_null_incorrect}
    ...    ${latest_file_stfiop}
    ...    0
    ${parser}=    Execute the command    ${install_parser_success_msg}
    Verify the msg    ${parser}    Completed installing parser
    ${3GPP32435BCS_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435BCS* | tail -n 1
    ${3GPP32435BCS}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435BCS_file}
    Verify the success or skipped msg    ${3GPP32435BCS}    Success    Skipped 3GPP32435BCS
    ${3GPP32435DYN_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435DYN* | tail -n 1
    ${3GPP32435DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435DYN_file}
    Verify the success or skipped msg    ${3GPP32435DYN}    Success    Skipped 3GPP32435DYN
    ${3GPP32435DYN_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435DYN* | tail -n 1
    ${3GPP32435DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435DYN_file}
    Verify the success or skipped msg    ${3GPP32435DYN}    Success    Skipped 3GPP32435DYN
    ${3GPP32435_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435* | tail -n 1
    ${3GPP32435}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435_file}
    Verify the success or skipped msg    ${3GPP32435}    Success    Skipped 3GPP32435
    ${HXMLCsIptnms_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLCsIptnms* | tail -n 1
    ${HXMLCsIptnms}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLCsIptnms_file}
    Verify the success or skipped msg    ${HXMLCsIptnms}    Success    Skipped HXMLCsIptnms
    ${HXMLPsIptnms_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLPsIptnms* | tail -n 1
    ${HXMLPsIptnms}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLPsIptnms_file}
    Verify the success or skipped msg    ${HXMLPsIptnms}    Success    Skipped HXMLPsIptnms
    ${MDC_CCN_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_CCN* | tail -n 1
    ${MDC_CCN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_CCN_file}
    Verify the success or skipped msg    ${MDC_CCN}    Success    Skipped MDC_CCN
    ${MDC_DYN_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_DYN* | tail -n 1
    ${MDC_DYN}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_DYN_file}
    Verify the success or skipped msg    ${MDC_DYN}    Success    Skipped MDC_DYN
    ${MDC_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art MDC* | tail -n 1
    ${MDC}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_file}
    Verify the success or skipped msg    ${MDC}    Success    Skipped MDC
    ${ascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ascii* | tail -n 1
    ${ascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ascii_file}
    Verify the success or skipped msg    ${ascii}    Success    Skipped ascii
    ${asn1_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art asn1* | tail -n 1
    ${asn1}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${asn1_file}
    Verify the success or skipped msg    ${asn1}    Success    Skipped asn1
    ${ebs_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs
    ${eascii_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii
    ${information_store_parser_file}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer ; ls -Art information_store_parser* | tail -n 1
    ${information_store_parser}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${information_store_parser_file}
    Verify the success or skipped msg    ${information_store_parser}    Success    Skipped information_store_parser
    ${kpiparser_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art kpiparser* | tail -n 1
    ${kpiparser}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${kpiparser_file}
    Verify the success or skipped msg    ${kpiparser}    Success    Skipped kpiparser
    ${minilink_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art minilink* | tail -n 1
    ${minilink}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${minilink_file}
    Verify the success or skipped msg    ${minilink}    Success    Skipped minilink
    ${mlxml_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art mlxml* | tail -n 1
    ${mlxml}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${mlxml_file}
    Verify the success or skipped msg    ${mlxml}    Success    Skipped mlxml
    ${nossdb_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art nossdb* | tail -n 1
    ${nossdb}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${nossdb_file}
    Verify the success or skipped msg    ${nossdb}    Success    Skipped nossdb
    ${redback_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art redback* | tail -n 1
    ${redback}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${redback_file}
    Verify the success or skipped msg    ${redback}    Success    Skipped redback
    ${sasn_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art sasn* | tail -n 1
    ${sasn}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${sasn_file}
    Verify the success or skipped msg    ${sasn}    Success    Skipped sasn
    ${stfiop_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art stfiop* | tail -n 1
    ${stfiop}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${stfiop_file}
    Verify the success or skipped msg    ${stfiop}    Success    Skipped stfiop
    ${twampm_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twampm* | tail -n 1
    ${twampm}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampm_file}
    Verify the success or skipped msg    ${twampm}    Success    Skipped twampm
    ${twamppt_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twamppt* | tail -n 1
    ${twamppt}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twamppt_file}
    Verify the success or skipped msg    ${twamppt}    Success    Skipped twamppt
    ${volte_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art volte* | tail -n 1
    ${volte}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${volte_file}
    Verify the success or skipped msg    ${volte}    Success    Skipped volte
    ${twampst_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art twampst* | tail -n 1
    ${twampst}=    Execute Command
    ...    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampst_file}
    Verify the success or skipped msg    ${twampst}    Success    Skipped twampst
    ${xml_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art xml* | tail -n 1
    ${xml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${xml_file}
    Verify the success or skipped msg    ${xml}    Success    Skipped xml
    ${ct_file}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; ls -Art ct* | tail -n 1
    ${ct}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ct_file}
    Verify the success or skipped msg    ${ct}    Success    Skipped ct


*** Keywords ***
Test Teardown
    Close All Connections
