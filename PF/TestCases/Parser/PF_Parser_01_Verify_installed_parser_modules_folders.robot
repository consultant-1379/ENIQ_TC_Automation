*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Verify installed parser modules folders are available in /eniq/sw/platform path
    Open connection as root user
    ${platform}=    Execute Command    find /eniq/sw/platform/ -type f -name "*.zip" -printf "%f\n"
    @{pf_dir_list} =    Split To Lines    ${platform}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_dir_files}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; find -type f -name "*.zip" -printf "%f\n"
    @{mws_dir_list} =    Split To Lines    ${mws_dir_files}
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

    #Negative Scenario 0 arg, like error, warning, exception, failed
    #Positive Scenario 1 arg, like Success, created, passed
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_parser}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_3GPP32435}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_3GPP32435BCS}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_3GPP32435DYN}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_HXMLCsIptnms}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_HXMLPsIptnms}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_MDC}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_MDC_CCN}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_MDC_PC}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_TCIMParser}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_ascii}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_asn1}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_bcd}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_nossdb}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_mrr}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_mlxml}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_minilink}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_ct}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_redback}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_sasn}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_twampm}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_twamppt}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_twampst}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_volte}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_csexport}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_ebs}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_eascii}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_xml}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_json}    0
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file_stfiop}    0
    ${parser}=    Execute the command    ${install_parser_success_msg}
    Verify the msg    ${parser}    Completed installing parser
    ${3GPP32435BCS_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435BCS* | tail -n 1
    ${3GPP32435BCS}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435BCS_file}
    Verify the success or skipped msg    ${3GPP32435BCS}    Success    Skipped 3GPP32435BCS
    ${3GPP32435DYN_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435DYN* | tail -n 1
    ${3GPP32435DYN}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435DYN_file}
    Verify the success or skipped msg    ${3GPP32435DYN}    Success    Skipped 3GPP32435DYN
    ${3GPP32435_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art 3GPP32435* | tail -n 1
    ${3GPP32435}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${3GPP32435_file}
    Verify the success or skipped msg    ${3GPP32435}    Success    Skipped 3GPP32435
    ${HXMLCsIptnms_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLCsIptnms* | tail -n 1
    ${HXMLCsIptnms}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLCsIptnms_file}
    Verify the success or skipped msg    ${HXMLCsIptnms}    Success    Skipped HXMLCsIptnms
    ${HXMLPsIptnms_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art HXMLPsIptnms* | tail -n 1
    ${HXMLPsIptnms}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${HXMLPsIptnms_file}
    Verify the success or skipped msg    ${HXMLPsIptnms}    Success    Skipped HXMLPsIptnms
    ${MDC_CCN_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_CCN* | tail -n 1
    ${MDC_CCN}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_CCN_file}
    Verify the success or skipped msg    ${MDC_CCN}    Success    Skipped MDC_CCN
    ${MDC_DYN_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art MDC_DYN* | tail -n 1
    ${MDC_DYN}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_DYN_file}
    Verify the success or skipped msg    ${MDC_DYN}    Success    Skipped MDC_DYN
    ${MDC_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art MDC* | tail -n 1
    ${MDC}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${MDC_file}
    Verify the success or skipped msg    ${MDC}    Success    Skipped MDC
    ${ascii_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ascii* | tail -n 1
    ${ascii}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ascii_file}
    Verify the success or skipped msg    ${ascii}    Success    Skipped ascii
    ${asn1_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art asn1* | tail -n 1
    ${asn1}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${asn1_file}
    Verify the success or skipped msg    ${asn1}    Success    Skipped asn1
    ${ebs_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs
    ${eascii_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii 
    ${information_store_parser_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art information_store_parser* | tail -n 1
    ${information_store_parser}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${information_store_parser_file}
    Verify the success or skipped msg    ${information_store_parser}    Success    Skipped information_store_parser
    ${kpiparser_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art kpiparser* | tail -n 1
    ${kpiparser}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${kpiparser_file}
    Verify the success or skipped msg    ${kpiparser}    Success    Skipped kpiparser
    ${mlxml_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art mlxml* | tail -n 1    
    ${mlxml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${mlxml_file}
    Verify the success or skipped msg    ${mlxml}    Success    Skipped mlxml  
    ${minilink_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art minilink* | tail -n 1
    ${minilink}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${minilink_file}
    Verify the success or skipped msg    ${minilink}    Success    Skipped minilink
    ${nossdb_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art nossdb* | tail -n 1
    ${nossdb}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${nossdb_file}
    Verify the success or skipped msg    ${nossdb}    Success    Skipped nossdb
    ${redback_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art redback* | tail -n 1
    ${redback}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${redback_file}
    Verify the success or skipped msg    ${redback}    Success    Skipped redback
    ${sasn_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art sasn* | tail -n 1
    ${sasn}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${sasn_file}
    Verify the success or skipped msg    ${sasn}    Success    Skipped sasn
    ${twampm_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art twampm* | tail -n 1
    ${twampm}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampm_file}
    Verify the success or skipped msg    ${twampm}    Success    Skipped twampm
    ${twamppt_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art twamppt* | tail -n 1
    ${twamppt}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twamppt_file}
    Verify the success or skipped msg    ${twamppt}    Success    Skipped twamppt
    ${twampst_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art twampst* | tail -n 1
    ${twampst}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${twampst_file}
    Verify the success or skipped msg    ${twampst}    Success    Skipped twampst
    ${volte_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art volte* | tail -n 1
    ${volte}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${volte_file}
    Verify the success or skipped msg    ${volte}    Success    Skipped volte
    ${csexport_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art csexport* | tail -n 1
    ${csexport}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${csexport_file}  
    Verify the success or skipped msg    ${csexport}    Success    Skipped csexport
    ${ebs_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ebs* | tail -n 1
    ${ebs}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ebs_file}      
    Verify the success or skipped msg    ${ebs}    Success    Skipped ebs
    ${eascii_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art eascii* | tail -n 1
    ${eascii}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${eascii_file}
    Verify the success or skipped msg    ${eascii}    Success    Skipped eascii      
    ${xml_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art xml* | tail -n 1
    ${xml}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${xml_file}
    Verify the success or skipped msg    ${xml}    Success    Skipped xml
    ${ct_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art ct* | tail -n 1
    ${ct}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${ct_file}
    Verify the success or skipped msg    ${ct}    Success    Skipped ct
    ${stfiop_file}=    Execute Command   cd /eniq/log/sw_log/platform_installer ; ls -Art stfiop* | tail -n 1
    ${stfiop}=    Execute Command    cd /eniq/log/sw_log/platform_installer/ && grep -iE 'success|skipped' ./${stfiop_file}
    Verify the success or skipped msg    ${stfiop}    Success    Skipped stfiop

*** Keywords ***
Test Teardown
    Close All Connections