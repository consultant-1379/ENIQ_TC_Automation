*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/Parser.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
*** Test Cases ***
Starting connection
    Connect to server as a dcuser

Verify installed parser modules folders are available in /eniq/sw/platform path
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
    ${3GPP32435BCS}=    Execute the command    ${install_3GPP32435BCS_success_msg}
    Verify the msg    ${3GPP32435BCS}    module.3GPP32435BCS
    Verify the msg    ${3GPP32435BCS}    Success
    ${3GPP32435DYN}=    Execute Command    ${install_3GPP32435DYN_success_msg}
    Verify the msg    ${3GPP32435DYN}    module.3GPP32435DYN
    Verify the msg    ${3GPP32435DYN}    Success
    ${3GPP32435}=    Execute the Command    ${install_3GPP32435_success_msg}
    Verify the msg    ${3GPP32435}    module.3GPP32435DYN
    Verify the msg    ${3GPP32435}    Success
    ${HXMLCsIptnms}=    Execute Command    ${install_HXMLCsIptnms_success_msg}
    Verify the msg    ${HXMLCsIptnms}    module.HXMLCsIptnms
    Verify the msg    ${HXMLCsIptnms}    Success
    ${HXMLPsIptnms}=    Execute the command    ${install_HXMLCsIptnms_success_msg}
    Verify the msg    ${HXMLPsIptnms}    module.HXMLCsIptnms
    Verify the msg    ${HXMLPsIptnms}    Success
    ${MDC_CCN}=    Execute the command    ${install_MDC_CCN_success_msg}
    Verify the msg    ${MDC_CCN}    module.MDC_CCN
    Verify the msg    ${MDC_CCN}    Success
    ${MDC_DYN}=    Execute the command    ${install_MDC_DYN_success_msg}
    Verify the msg    ${MDC_DYN}    module.MDC_DYN
    Verify the msg    ${MDC_DYN}    Success
    ${MDC}=    Execute the command    ${install_MDC_success_msg}
    Verify the msg    ${MDC}    module.MDC
    Verify the msg    ${MDC}    Success
    ${ascii}=    Execute the command    ${install_ascii_success_msg}
    Verify the msg    ${ascii}    module.ascii
    Verify the msg    ${ascii}    Success
    ${asn1}=    Execute the command    ${install_asn1_success_msg}
    Verify the msg    ${asn1}    module.asn1
    Verify the msg    ${asn1}    Success
    ${ebs}=    Execute the command    ${install_ebs_success_msg}
    Verify the msg    ${ebs}    module.ebs
    Verify the msg    ${ebs}    Success
    ${eascii}=    Execute the command    ${install_eascii_success_msg}
    Verify the msg    ${eascii}    module.eascii
    Verify the msg    ${eascii}    Success
    ${information_store_parser}=    Execute the command    ${install_information_success_msg}
    Verify the msg    ${information_store_parser}    module.information_store_parser
    Verify the msg    ${information_store_parser}    Success
    ${kpiparser}=    Execute the command    ${install_kpiparser_success_msg}
    Verify the msg    ${kpiparser}    module.kpiparser
    Verify the msg    ${kpiparser}    Success
    ${mlxml}=    Execute the command    ${install_mlxml_success_msg}
    Verify the msg    ${mlxml}    module.mlxml
    Verify the msg    ${mlxml}    Success  
    ${minilink}=    Execute the command    ${install_minilink_success_msg}
    Verify the msg    ${minilink}    module.minilink
    Verify the msg    ${minilink}    Success
    ${ct}=    Execute the command    ${install_ct_success_msg}
    Verify the msg    ${ct}    module.ct
    Verify the msg    ${ct}    Success  
    ${redback}=    Execute the command    ${install_redback_success_msg}
    Verify the msg    ${redback}    module.redback
    Verify the msg    ${redback}    Success
    ${sasn}=    Execute the command    ${install_sasn_success_msg}
    Verify the msg    ${sasn}    module.sasn
    Verify the msg    ${sasn}    Success
    ${twampm}=    Execute the command    ${install_twampm_success_msg}
    Verify the msg    ${twampm}    module.twampm
    Verify the msg    ${twampm}    Success
    ${twamppt}=    Execute the command    ${install_twamppt_success_msg}
    Verify the msg    ${twamppt}    module.twamppt
    Verify the msg    ${twamppt}    Success
    ${twampst}=    Execute the command    ${install_twampst_success_msg}
    Verify the msg    ${twampst}    module.twampst
    Verify the msg    ${twampst}    Success
    ${volte}=    Execute the command    ${install_volte_success_msg}
    Verify the msg    ${volte}    module.volte
    Verify the msg    ${volte}    Success
    ${csexport}=    Execute the command    ${install_csexport_success_msg}
    Verify the msg    ${csexport}    module.csexport
    Verify the msg    ${csexport}    Success
    ${ebs}=    Execute the command    ${install_ebs_success_msg}
    Verify the msg    ${ebs}    module.ebs
    Verify the msg    ${ebs}    Success
    ${eascii}=    Execute the command    ${install_eascii_success_msg}
    Verify the msg    ${eascii}    module.eascii
    Verify the msg    ${eascii}    Success
    ${xml}=    Execute the command    ${install_xml_success_msg}
    Verify the msg    ${xml}    module.xml
    Verify the msg    ${xml}    Success
    ${json}=    Execute the command    ${install_json_success_msg}
    Verify the msg    ${json}    module.json
    Verify the msg    ${json}    Success
    ${stfiop}=    Execute the command    ${install_stfiop_success_msg}
    Verify the msg    ${stfiop}    module.stfiop
    Verify the msg    ${stfiop}    Success

Validate the parser module version is updated in versiondb.properties file
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

Validate the 3GPP32435BCS module version is updated in versiondb.properties file
    ${grep_3GPP32435BC}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435BCS 
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435BC}    .*3GPP32435BCS\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435BCS
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435BCS\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435BCS
    ${mws_grep_3GPP32435BC}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435BCS\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_3GPP32435BC}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435BCS*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435BCS}=    Execute the command    ${install_3GPP32435BCS_success_msg}
    Verify the msg    ${3GPP32435BCS}    module.3GPP32435BCS
    Verify the msg    ${3GPP32435BCS}    Success

Validate the 3GPP32435DYN module version is updated in versiondb.properties file
    ${grep_3GPP32435DYN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435DYN 
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435DYN}    .*3GPP32435DYN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435DYN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435DYN\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435DYN
    ${mws_grep_3GPP32435DYN}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435DYN\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_3GPP32435DYN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435DYN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435DYN}=    Execute Command    ${install_3GPP32435DYN_success_msg}
    Verify the msg    ${3GPP32435DYN}    module.3GPP32435DYN
    Verify the msg    ${3GPP32435DYN}    Success

Validate the 3GPP32435 module version is updated in versiondb.properties file
    ${grep_3GPP32435}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w 3GPP32435 
    ${platform}=    Remove String Using Regexp    ${grep_3GPP32435}    .*3GPP32435\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w 3GPP32435
    ${Version}=    Remove String Using Regexp    ${version_db}    .*3GPP32435\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^3GPP32435_
    ${mws_grep_3GPP32435}=    Remove String Using Regexp    ${mws_path}    .*3GPP32435\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_3GPP32435}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    3GPP32435*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${3GPP32435}=    Execute the Command    ${install_3GPP32435_success_msg}
    Verify the msg    ${3GPP32435}    module.3GPP32435
    Verify the msg    ${3GPP32435}    Success

Validate the HXMLCsIptnms module version is updated in versiondb.properties file
    ${grep_HXMLCsIptnms}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w HXMLCsIptnms
    ${platform}=    Remove String Using Regexp    ${grep_HXMLCsIptnms}    .*HXMLCsIptnms\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w HXMLCsIptnms
    ${Version}=    Remove String Using Regexp    ${version_db}    .*HXMLCsIptnms\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^HXMLCsIptnms
    ${mws_grep_HXMLCsIptnms}=    Remove String Using Regexp    ${mws_path}    .*HXMLCsIptnms\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_HXMLCsIptnms}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    HXMLCsIptnms*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${HXMLCsIptnms}=    Execute Command    ${install_HXMLCsIptnms_success_msg}
    Verify the msg    ${HXMLCsIptnms}    module.HXMLCsIptnms
    Verify the msg    ${HXMLCsIptnms}    Success

Validate the HXMLPsIptnms module version is updated in versiondb.properties file
    ${grep_HXMLPsIptnms}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w HXMLPsIptnms
    ${platform}=    Remove String Using Regexp    ${grep_HXMLPsIptnms}    .*HXMLPsIptnms\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w HXMLPsIptnms
    ${Version}=    Remove String Using Regexp    ${version_db}    .*HXMLPsIptnms\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^HXMLPsIptnms
    ${mws_grep_HXMLPsIptnms}=    Remove String Using Regexp    ${mws_path}    .*HXMLPsIptnms\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_HXMLPsIptnms}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    HXMLPsIptnms*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${HXMLPsIptnms}=    Execute the command    ${install_HXMLPsIptnms_success_msg}
    Verify the msg    ${HXMLPsIptnms}    module.HXMLPsIptnms
    Verify the msg    ${HXMLPsIptnms}    Success

Validate the MDC_CCN module version is updated in versiondb.properties file
    ${grep_MDC_CCN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC_CCN
    ${platform}=    Remove String Using Regexp    ${grep_MDC_CCN}    .*MDC_CCN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC_CCN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC_CCN\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_CCN
    ${mws_grep_MDC_CCN}=    Remove String Using Regexp    ${mws_path}    .*MDC_CCN\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_MDC_CCN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC_CCN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_CCN}=    Execute the command    ${install_MDC_CCN_success_msg}
    Verify the msg    ${MDC_CCN}    module.MDC_CCN
    Verify the msg    ${MDC_CCN}    Success

Validate the MDC_DYN module version is updated in versiondb.properties file
    ${grep_MDC_DYN}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC_DYN
    ${platform}=    Remove String Using Regexp    ${grep_MDC_DYN}    .*MDC_DYN\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC_DYN
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC_DYN\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_DYN
    ${mws_grep_MDC_DYN}=    Remove String Using Regexp    ${mws_path}    .*MDC_DYN\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_MDC_DYN}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC_DYN*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC_DYN}=    Execute the command    ${install_MDC_DYN_success_msg}
    Verify the msg    ${MDC_DYN}    module.MDC_DYN
    Verify the msg    ${MDC_DYN}    Success

Validate the MDC module version is updated in versiondb.properties file
    ${grep_MDC}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w MDC
    ${platform}=    Remove String Using Regexp    ${grep_MDC}    .*MDC\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w MDC
    ${Version}=    Remove String Using Regexp    ${version_db}    .*MDC\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^MDC_R
    ${mws_grep_MDC}=    Remove String Using Regexp    ${mws_path}    .*MDC\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_MDC}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    MDC*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${MDC}=    Execute the command    ${install_MDC_success_msg}
    Verify the msg    ${MDC}    module.MDC
    Verify the msg    ${MDC}    Success

Validate the ascii module version is updated in versiondb.properties file
    ${grep_ascii}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ascii
    ${platform}=    Remove String Using Regexp    ${grep_ascii}    .*ascii\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ascii
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ascii\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ascii
    ${mws_grep_ascii}=    Remove String Using Regexp    ${mws_path}    .*ascii\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_ascii}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ascii*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ascii}=    Execute the command    ${install_ascii_success_msg}
    Verify the msg    ${ascii}    module.ascii
    Verify the msg    ${ascii}    Success

Validate the asn1 module version is updated in versiondb.properties file
    ${grep_asn1}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w asn1
    ${platform}=    Remove String Using Regexp    ${grep_asn1}    .*asn1\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w asn1
    ${Version}=    Remove String Using Regexp    ${version_db}    .*asn1\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^asn1
    ${mws_grep_asn1}=    Remove String Using Regexp    ${mws_path}    .*asn1\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_asn1}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    asn1*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${asn1}=    Execute the command    ${install_asn1_success_msg}
    Verify the msg    ${asn1}    module.asn1
    Verify the msg    ${asn1}    Success

Validate the ebs module version is updated in versiondb.properties file
    ${grep_ebs}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ebs
    ${platform}=    Remove String Using Regexp    ${grep_ebs}    .*ebs\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ebs
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ebs\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ebs
    ${mws_grep_ebs}=    Remove String Using Regexp    ${mws_path}    .*ebs\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_ebs}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ebs*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ebs}=    Execute the command    ${install_ebs_success_msg}
    Verify the msg    ${ebs}    module.ebs
    Verify the msg    ${ebs}    Success

Validate the eascii module version is updated in versiondb.properties file
    ${grep_eascii}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w eascii
    ${platform}=    Remove String Using Regexp    ${grep_eascii}    .*eascii\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w eascii
    ${Version}=    Remove String Using Regexp    ${version_db}    .*eascii\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^eascii
    ${mws_grep_eascii}=    Remove String Using Regexp    ${mws_path}    .*eascii\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_eascii}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    eascii*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${eascii}=    Execute the command    ${install_eascii_success_msg}
    Verify the msg    ${eascii}    module.eascii
    Verify the msg    ${eascii}    Success

Validate the information_store_parser module version is updated in versiondb.properties file
    ${grep_information_store_parser}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w information_store_parser
    ${platform}=    Remove String Using Regexp    ${grep_information_store_parser}    .*information_store_parser\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w information_store_parser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*information_store_parser\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^information_store_parser
    ${mws_grep_information_store_parser}=    Remove String Using Regexp    ${mws_path}    .*information_store_parser\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_information_store_parser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    information_store_parser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${information_store_parser}=    Execute the command    ${install_information_success_msg}
    Verify the msg    ${information_store_parser}    module.information_store_parser
    Verify the msg    ${information_store_parser}    Success

Validate the kpiparser module version is updated in versiondb.properties file
    ${grep_kpiparser}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w kpiparser
    ${platform}=    Remove String Using Regexp    ${grep_kpiparser}    .*kpiparser\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w kpiparser
    ${Version}=    Remove String Using Regexp    ${version_db}    .*kpiparser\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^kpiparser
    ${mws_grep_kpiparser}=    Remove String Using Regexp    ${mws_path}    .*kpiparser\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_kpiparser}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    kpiparser*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${kpiparser}=    Execute the command    ${install_kpiparser_success_msg}
    Verify the msg    ${kpiparser}    module.kpiparser
    Verify the msg    ${kpiparser}    Success

Validate the minilink module version is updated in versiondb.properties file
    ${grep_minilink}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w minilink
    ${platform}=    Remove String Using Regexp    ${grep_minilink}    .*minilink\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w minilink
    ${Version}=    Remove String Using Regexp    ${version_db}    .*minilink\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^minilink
    ${mws_grep_minilink}=    Remove String Using Regexp    ${mws_path}    .*minilink\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_minilink}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    minilink*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${minilink}=    Execute the command    ${install_minilink_success_msg}
    Verify the msg    ${minilink}    module.minilink
    Verify the msg    ${minilink}    Success

Validate the mlxml module version is updated in versiondb.properties file
    ${grep_mlxml}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w mlxml
    ${platform}=    Remove String Using Regexp    ${grep_mlxml}    .*mlxml\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w mlxml
    ${Version}=    Remove String Using Regexp    ${version_db}    .*mlxml\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^mlxml
    ${mws_grep_mlxml}=    Remove String Using Regexp    ${mws_path}    .*mlxml\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_mlxml}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    mlxml*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${mlxml}=    Execute the command    ${install_mlxml_success_msg}
    Verify the msg    ${mlxml}    module.mlxml
    Verify the msg    ${mlxml}    Success

Validate the nossdb module version is updated in versiondb.properties file
    ${grep_nossdb}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w nossdb
    ${platform}=    Remove String Using Regexp    ${grep_nossdb}    .*nossdb\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w nossdb
    ${Version}=    Remove String Using Regexp    ${version_db}    .*nossdb\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^nossdb
    ${mws_grep_nossdb}=    Remove String Using Regexp    ${mws_path}    .*nossdb\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_nossdb}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    nossdb*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${nossdb}=    Execute the command    ${install_nossdb_success_msg}
    Verify the msg    ${nossdb}    module.nossdb
    Verify the msg    ${nossdb}    Success

Validate the redback module version is updated in versiondb.properties file
    ${grep_redback}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w redback
    ${platform}=    Remove String Using Regexp    ${grep_redback}    .*redback\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w redback
    ${Version}=    Remove String Using Regexp    ${version_db}    .*redback\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^redback
    ${mws_grep_redback}=    Remove String Using Regexp    ${mws_path}    .*redback\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_redback}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    redback*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${redback}=    Execute the command    ${install_redback_success_msg}
    Verify the msg    ${redback}    module.redback
    Verify the msg    ${redback}    Success

Validate the sasn module version is updated in versiondb.properties file
    ${grep_sasn}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w sasn
    ${platform}=    Remove String Using Regexp    ${grep_sasn}    .*sasn\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w sasn
    ${Version}=    Remove String Using Regexp    ${version_db}    .*sasn\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^sasn
    ${mws_grep_sasn}=    Remove String Using Regexp    ${mws_path}    .*sasn\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_sasn}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    sasn*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${sasn}=    Execute the command    ${install_sasn_success_msg}
    Verify the msg    ${sasn}    module.sasn
    Verify the msg    ${sasn}    Success

Validate the stfiop module version is updated in versiondb.properties file
    ${grep_stfiop}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w stfiop
    ${platform}=    Remove String Using Regexp    ${grep_stfiop}    .*stfiop\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w stfiop
    ${Version}=    Remove String Using Regexp    ${version_db}    .*stfiop\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^stfiop
    ${mws_grep_stfiop}=    Remove String Using Regexp    ${mws_path}    .*stfiop\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_stfiop}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    stfiop*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${stfiop}=    Execute the command    ${install_stfiop_success_msg}
    Verify the msg    ${stfiop}    module.stfiop
    Verify the msg    ${stfiop}    Success 

Validate the twampm module version is updated in versiondb.properties file
    ${grep_twampm}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twampm
    ${platform}=    Remove String Using Regexp    ${grep_twampm}    .*twampm\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twampm
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twampm\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twampm
    ${mws_grep_twampm}=    Remove String Using Regexp    ${mws_path}    .*twampm\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_twampm}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twampm*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twampm}=    Execute the command    ${install_twampm_success_msg}
    Verify the msg    ${twampm}    module.twampm
    Verify the msg    ${twampm}    Success

Validate the twamppt module version is updated in versiondb.properties file
    ${grep_twamppt}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twamppt
    ${platform}=    Remove String Using Regexp    ${grep_twamppt}    .*twamppt\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twamppt
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twamppt\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twamppt
    ${mws_grep_twamppt}=    Remove String Using Regexp    ${mws_path}    .*twamppt\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_twamppt}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twamppt*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twamppt}=    Execute the command    ${install_twamppt_success_msg}
    Verify the msg    ${twamppt}    module.twamppt
    Verify the msg    ${twamppt}    Success

Validate the twampst module version is updated in versiondb.properties file
    ${grep_twampst}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w twampst
    ${platform}=    Remove String Using Regexp    ${grep_twampst}    .*twampst\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w twampst
    ${Version}=    Remove String Using Regexp    ${version_db}    .*twampst\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^twampst
    ${mws_grep_twampst}=    Remove String Using Regexp    ${mws_path}    .*twampst\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_twampst}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    twampst*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${twampst}=    Execute the command    ${install_twampst_success_msg}
    Verify the msg    ${twampst}    module.twampst
    Verify the msg    ${twampst}    Success

Validate the volte module version is updated in versiondb.properties file
    ${grep_volte}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w volte
    ${platform}=    Remove String Using Regexp    ${grep_volte}    .*volte\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w volte
    ${Version}=    Remove String Using Regexp    ${version_db}    .*volte\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^volte
    ${mws_grep_volte}=    Remove String Using Regexp    ${mws_path}    .*volte\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_volte}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    volte*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${volte}=    Execute the command    ${install_volte_success_msg}
    Verify the msg    ${volte}    module.volte
    Verify the msg    ${volte}    Success

Validate the xml module version is updated in versiondb.properties file
    ${grep_xml}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w xml
    ${platform}=    Remove String Using Regexp    ${grep_xml}    .*xml\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w xml
    ${Version}=    Remove String Using Regexp    ${version_db}    .*xml\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^xml
    ${mws_grep_xml}=    Remove String Using Regexp    ${mws_path}    .*xml\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_xml}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    xml*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${xml}=    Execute the command    ${install_xml_success_msg}
    Verify the msg    ${xml}    module.xml
    Verify the msg    ${xml}    Success

Validate the ct module version is updated in versiondb.properties file
    ${grep_ct}=    Execute Command    cd /eniq/sw/platform ; ls | grep -w ct
    ${platform}=    Remove String Using Regexp    ${grep_ct}    .*ct\\S
    ${version_db}=    Execute Command    cd /eniq/sw/installer ; cat versiondb.properties | grep -w ct
    ${Version}=    Remove String Using Regexp    ${version_db}    .*ct\\S
    Should Be Equal    ${platform}    ${Version}
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_parsers/; ls | grep -i ^ct
    ${mws_grep_ct}=    Remove String Using Regexp    ${mws_path}    .*ct\\S    .zip
    Should Be Equal    ${platform}    ${mws_grep_ct}
    Execute the command    ${platform_installer}
    ${latest_file}=    Get latest file from directory    ct*
    Validate the log file for    ${no_error_warning_execption_failed_notfound_null_incorrect}    ${latest_file}    0
    ${ct}=    Execute the command    ${install_ct_success_msg}
    Verify the msg    ${ct}    module.ct
    Verify the msg    ${ct}    Success

Verify the engine logs of All parser modules
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
    ${parser_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat parser* |grep -i 'Successfully installed'
    Verify the msg    ${parser_success_msg}    Successfully installed
    ${3GPP32435_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat 3GPP32435_R* |grep -i 'Successfully installed'
    Verify the msg    ${3GPP32435_success_msg}    Successfully installed 
    ${3GPP32435BCS_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat 3GPP32435BCS* |grep -i 'Successfully installed'
    Verify the msg    ${3GPP32435BCS_success_msg}    Successfully installed
    ${3GPP32435DYN_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat 3GPP32435DYN* |grep -i 'Successfully installed'
    Verify the msg    ${3GPP32435DYN_success_msg}    Successfully installed
    ${HXMLCsIptnms_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat HXMLCsIptnms* |grep -i 'Successfully installed'
    Verify the msg    ${HXMLCsIptnms_success_msg}    Successfully installed
    ${HXMLPsIptnms_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat HXMLPsIptnms* |grep -i 'Successfully installed'
    Verify the msg    ${HXMLCsIptnms_success_msg}    Successfully installed                  
    ${MDC_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat MDC_R* |grep -i 'Successfully installed'
    Verify the msg    ${MDC_success_msg}    Successfully installed
    ${MDC_CCN_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat MDC_R* |grep -i 'Successfully installed'    
    Verify the msg    ${MDC__CCN_success_msg}    Successfully installed
    ${MDC_PC_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat MDC_PC* |grep -i 'Successfully installed'
    Verify the msg    ${MDC_PC_success_msg}    Successfully installed
    ${TCIMParser_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat TCIMParser* |grep -i 'Successfully installed'
    Verify the msg    ${TCIMParser_success_msg}    Successfully installed
    ${ascii_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat ascii* |grep -i 'Successfully installed'
    Verify the msg    ${ascii_success_msg}    Successfully installed                  
    ${asn1_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat asn1* |grep -i 'Successfully installed'
    Verify the msg    ${asn1_success_msg}    Successfully installed
    ${bcd_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat bcd* |grep -i 'Successfully installed'
    Verify the msg    ${bcd_success_msg}    Successfully installed
    ${nossdb_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat nossdb* |grep -i 'Successfully installed'
    Verify the msg    ${nossdb_success_msg}    Successfully installed
    ${mrr_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat mrr* |grep -i 'Successfully installed'
    Verify the msg    ${mrr_success_msg}    Successfully installed                  
    ${mlxml_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat mlxml* |grep -i 'Successfully installed'
    Verify the msg    ${mlxml_success_msg}    Successfully installed
    ${minilink_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat minilink* |grep -i 'Successfully installed'
    Verify the msg    ${minilink_success_msg}    Successfully installed
    ${ct_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat ct* |grep -i 'Successfully installed'
    Verify the msg    ${ct_success_msg}    Successfully installed
    ${redback_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat redback* |grep -i 'Successfully installed'
    Verify the msg    ${redback_success_msg}    Successfully installed
    ${sasn_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat sasn* |grep -i 'Successfully installed'
    Verify the msg    ${sasn_success_msg}    Successfully installed                  
    ${twampm_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat twampm* |grep -i 'Successfully installed'
    Verify the msg    ${twampm_success_msg}    Successfully installed
    ${twamppt_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat twamppt* |grep -i 'Successfully installed'
    Verify the msg    ${twamppt_success_msg}    Successfully installed
    ${twampst_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat twampst* |grep -i 'Successfully installed'
    Verify the msg    ${twampst_success_msg}    Successfully installed
    ${volte_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat volte* |grep -i 'Successfully installed'
    Verify the msg    ${volte_success_msg}    Successfully installed
    ${csexport_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat csexport* |grep -i 'Successfully installed'
    Verify the msg    ${sasn_success_msg}    Successfully installed                  
    ${ebs_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat ebs* |grep -i 'Successfully installed'
    Verify the msg    ${ebs_success_msg}    Successfully installed
    ${eascii_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat eascii* |grep -i 'Successfully installed'
    Verify the msg    ${eascii_success_msg}    Successfully installed
    ${xml_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat xml* |grep -i 'Successfully installed'
    Verify the msg    ${xml_success_msg}    Successfully installed
    ${json_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat json* |grep -i 'Successfully installed'
    Verify the msg    ${json_success_msg}    Successfully installed                  
    ${stfiop_success_msg}=    Execute Command    cd /eniq/log/sw_log/platform_installer ; cat stfiop* |grep -i 'Successfully installed'
    Verify the msg    ${stfiop_success_msg}    Successfully installed

close the connection
    Close All Connections


