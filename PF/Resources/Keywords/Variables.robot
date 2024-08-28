*** Variables ***

${DELAY}          0
${SERVER}    ieatrcxb6080       
#${SERVER_6082}    ieatrcx8399
${SERVER IP}    10.45.197.180
${PORT}    8443
${Login_AdminUI_URL}    https://${SERVER}.athtem.eei.ericsson.se:${PORT}/adminui
${vapp_url}    https://${SERVER}.athtem.eei.ericsson.se:${PORT}/adminui
${Login_AdminUI_URL_6082}    https://${SERVER}.athtem.eei.ericsson.se:${PORT}/adminui
${physical_server_url}    https://${SERVER_8399}.athtem.eei.ericsson.se:${PORT}/adminui
${LOGIN URL WITH IP}    https://${SERVER IP}:${PORT}/adminui
${LOGIN URL WITH WRONG PORT}    http://${SERVER}.athtem.eei.ericsson.se:8080/adminui/

${USERNAME}    pftest
${PASSWORD}    Pftest12
#${USERNAME_6082}    eniq1
#${PASSWORD_6082}    Eniq@123
#${USERNAME_8399}    Eniq
#${PASSWORD_8399}    Eniq@123
${WRONG PORT}    8080
${WRONG URL}    https://${SERVER}:${WRONG PORT}/adminui
#${username_01}    Lap
#${password_02}    Lap@1234					 
${SERVER_8399}    ieatrcx8399

${FAILED LOGIN ERROR}    Login failed
${LOCKED OUT ERROR}    has been locked 

${CHROME BROWSER}    Chrome
${IE BROWSER}    IE
${EDGE BROWSER}    Edge
${FIREFOX BROWSER}    Firefox
${service_name}    engine
${host_123}    ieatrcx8399.athtem.eei.ericsson.se
${port_for_vapp}    22
${user_for_vapp}    dcuser
${pass_for_vapp}	Dcuser%12
${root_user}    root
${root password}    Plat@6080
${root_pswd}    shroot12
${non_rootuser}    manuser
${non_rootpass}    Laptop@123
${non_user}    DmCi
${non_pass}    EniqStats%123	


#${host}    ieatrcxb6080.athtem.eei.ericsson.se
#${host_6082}    ieatrcxb6082.athtem.eei.ericsson.se
#${host_8399}    ieatrcx8399.athtem.eei.ericsson.se
#${port_for_6082}    22
#${username_for_6082}    dcuser
#${password_for_6082}    Dcuser%12
#${port_for_6080}    22
#${username_for_6080}    dcuser
#${password_for_6080}    Dcuser%12
${status}    fls status
${stop}    fls stop
${start}    fls start
${status}    fls status
${symlink}    /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_eniq_oss_2-2020_04_24.log | grep -i 'restoreMaxIdToken method java.io.EOFException'
${maxtoken}    /eniq/log/sw_log/symboliclinkcreator/symboliclinkcreator_eniq_oss_2-2020_04_24.log | grep -i 'Exception at MaxidToken value null'
${Enm}    /eniq/sw/installer
${Enm-2}    /eniq/sw/conf/.oss_ref_name_file
${fls_conf}    /eniq/installation/config/fls_conf
${sw_log}    cd /eniq/log/sw_log/adminui
${installer path}    cd /eniq/sw/installer
${service-3}    /eniq/sw/conf/service_names
${services-4}    cat /etc/hosts
${ingress ip}    /etc/hosts
${conf}    /eniq/sw/conf/
${service check}    services -s eniq
${truststore}    /eniq/sw/runtime/jdk/jre/lib/security/
${ls-lrt}    ls -lrt
${file}    truststore.ts
${symboliclinkcreator}    /eniq/log/sw_log/symboliclinkcreator/
${connectd}    /eniq/connectd/mount_info
${eniq_oss_3}    eniq_oss_3
${enm_type}    enm_type
${eniq_oss_4}    eniq_oss_4
${eniq_oss_5}    eniq_oss_5
${dummy}    /eniq/data/pmdata/eniq_oss_*
${c#}    c#
${installer}    /eniq/sw/installer
${installer_folder}    cd /eniq/sw/installer
${server details}    /eniq/sw/conf/enmserverdetail
${cenm}    10.32.187.32 ieatenmc11a007.athtem.eei.ericsson.se ENM cenm6080 Q2VubUA2MDgwCg== ieatrcxb6080
${conntd-1}    /eniq/connectd/mount_info/eniq_oss*
${conntd-2}    /eniq/connectd/mount_info/eniq_oss_4
${conntd-3}    /eniq/connectd/mount_info/eniq_oss_5
${alias_id_2}    /eniq/connectd/mount_info/eniq_oss_2
${conntd-4}     cd /eniq/data/pmdata/eniq_oss_5/lte/topologydata/ERBS
${ls}    ls
${active}    active
${inactive}    inactive
${.ser}    MixedNodeCachePersisted_eniq_oss_2.ser
${lrth}    ls -lrth
${security_path}    /eniq/sw/runtime/jdk/jre/lib/security/
${db_connection_url}    dbisql -c "UID=dwhrep;PWD=Dwhrep12#;eng=repdb" -host localhost -port 2641 -nogui
${inDir}    /eniq/data/pmdata/eniq_oss_5
${mount}      /eniq/connectd/mount_info/eniq_oss_4
${symlink4}    symboliclinkcreator_eniq_oss_2
${delete_NAT_table_query}     delete from ENIQS_Node_Assignment
${select_NAT_table_query}     select * from ENIQS_Node_Assignment
${symlink5}    symboliclinkcreator_eniq_oss_5
${symlink2}    symboliclinkcreator_eniq_oss_2
${NAT}     dbisql -c "UID=dwhrep;PWD=Dwhrep12#;eng=repdb" -host localhost -port 2641 -nogui
${cmpltd}    Completed successfully
${FLS}    FLS is running
@{list_of_active_services_fls}    eniq-connectd.service    eniq-dwhdb.service    eniq-engine.service    eniq-esm.service    eniq-fls.service    eniq-licmgr.service    eniq-lwphelper.service    eniq-repdb.service    eniq-rmiregistry.service    eniq-scheduler.service    eniq-webserver.service   
@{list_of_inactive_services_fls}    eniq-dwh_reader.service     eniq-roll-snap.service
${nfd}       lte
${eniq1}    eniq-connectd.service
${one_minute}    1MIN
${five_minute}    5MIN
${disable_OSS}    disable_OSS
${fls_restart}    fls restart
${rows_deleted}    deleted
${bin}    cd /eniq/admin/bin
${Restart_command}     bash ./manage_deployment_services.bsh -a restart -s ALL
${system_services}     systemctl -t service | grep -i eniq
@{sub_dirs}    <subdir>dir1</subdir>    <subdir>dir2</subdir>    <subdir>dir3</subdir>    <subdir>dir4</subdir>    <subdir>dir5</subdir>




# **** Adminui Variables *****
${tomcat_add user}    ./manage_tomcat_user.bsh -A ADD_USER
${newuser id}	Testeniq   
${password id}	Testeniq@123    
${uppercase password}    PLATFORM
${upper_case}    Password should contain atleast one upper case letter, provide the valid password to proceed
${password with space}    plat form
${space}    Password provided has space in it, provide the valid password to proceed   
${lower case password}    platform
${lower_case}    Password should contain atleast one lower case letter, provide the valid password to proceed
${four letters character}    plat
${eight character}    Length of Password provided is less than 8 characters, provide the valid password to proceed
${Get_sessions script}    ./adminui_sessions.bsh -A GET_SESSIONS
${Set_sessions script}    ./adminui_sessions.bsh -A SET_SESSIONS
${Get_sessions_timeout}    ./adminui_sessions.bsh -A GET_SESSION_TIMEOUT
${Set_sessions_timeout}    ./adminui_sessions.bsh -A SET_SESSION_TIMEOUT
${session number}    Number of Logon sessions set is
${session timeout}    User session timeout is set to
${Number of sessions}    2
${tomcat remove_user}    ./manage_tomcat_user.bsh -A REMOVE_USER
${removeuser_password check}    User removed successfully for user
${New session timeout value in min}    6
${tomcat change_password}    ./manage_tomcat_user.bsh -A CHANGE_PASSWORD
#${change_password username}    user2
${New password}    Book@123    
#${existing password}    Lap@1234
${existing matching password}    Password is matching, enter the new password:
${updated password}    Password updated successfully for user     
${new legal notice}    Edited by Automation YOU ARE NOT AN AUTHORIZED USER STOP ANY ACTIVITY.YOU ARE PERFORMING ON THIS SYSTEM AND EXIT IMMEDIATELY.
${new legal notice id}    lwmsg
${webapps path}    /eniq/sw/runtime/tomcat/webapps/adminui/conf/
${message properties}    message.properties
${Custom message}    CUSTOM_MESSAGE
${existing legal notice}    IF YOU ARE NOT AN AUTHORIZED USER STOP ANY ACTIVITY.YOU ARE PERFORMING ON THIS SYSTEM AND EXIT IMMEDIATELY.\n\nThis system is provided for authorized and official use only.\nThe usage of this system is monitored and audited.\nUnauthorized or improper usage may result in disciplinary actions, civil or criminal penalties.                              
${legal sucessfully msg}    Legal Notice message is updated successfully.Please Login again    
${Eniqs_password_input_id}    updatepassword        
#${continue}    //input[@name="Continue"]
${root password submit}    //input[@name="Update"]
${sw_log}    cd /eniq/log/sw_log/adminui
${Session_timeout_min}    6    
${feature}    //*[@id="CXC4011500"]
${Eniq-s password}    installpassword
${Feature update overview}    Feature Update Overview
${Feature Installation Status}    Feature Installation Status
${custom user}    custom
${custom pwd}    Custom@123
${oldPasswordId}    op
${newPasswordId}    np
${confirmNewPasswordId}    cnp
#${change_OldPassword}    Deep@1212
${change_newPassword}    Ericsson@123
${changePasswordSpecialCharacter}    Deep@<123
${changePasswordErrorMsg}    Please enter new password according to rule
${paswordChangeMsg}    Password successfully changed. Restarting webserver
${LoginFailedMsg}    Login failed, please check your username and password
${Logon_session_msg}    Number of Logon sessions set is
${Logon_session_updated_msg}    Number of Logon sessions has been updated
${User_session_timeout}    User session timeout has been updated
${DSC PM Tech Pack}    //*[@id="CXC4011500"]
${commit button}    //input[@name="Commit"]
@{install_feature}    ${MGW_PM_Tech_Pack}        ${WCG_PM_Tech_Pack}    ${HSS_PM_Tech_Pack}    ${Sasn_PM_Tech_Pack}    ${vEME PM Tech Pack}
${MGW_PM_Tech_Pack}    CXC4011086
${WCG_PM_Tech_Pack}    CXC4011832
${HSS_PM_Tech_Pack}    CXC4010797
${Sasn_PM_Tech_Pack}    CXC4010591
${vEME PM Tech Pack}    CXC4012115
${privileged_script}    bash /eniq/installation/core_install/bin/manage_privileged_users.bsh
${Legal_message_xpath}    xpath=//*[@class="indented"]/p
${Rollback_ENIQ_Privileged_User}    4
${Enable_ENIQ_Privileged_User}    1
${Finish_button}    //input[@value="Finish"]
${run}    Go



### Engine Module ###
${root_user}    root
${root_pwd}    shroot@12
${platform_installer}    cd /eniq/log/sw_log/platform_installer
${no_error_warning_exception_failed}    warning\\|exception\\|severe\\|not found\\|error
${successfully_installation}    same version is already installed\\|BUILD SUCCESSFUL\\|successfully installed\\|Already higher version
@{successful_msg}    Same version is already installed    BUILD SUCCESSFUL    Successfully installed	Already higher version
${engine_service_status}    systemctl status eniq-engine.service
${profile_noloads}    Changing profile to: NoLoads
${profile_normal}    Changing profile to: Normal
${license_manager_Network_IQ_Starter}    licmgr -getlicinfo | grep -i -A 3 'Ericsson Network IQ Starter' 
${license_manager_IQ_Eniq_Capacity}    licmgr -getlicinfo | grep -i -A 3 'ENIQ Capacity'
${license_manager_expire_date}    Expiration
${pm_data}    cd /eniq/data/pmdata/
${Engine_Logs}    cd /eniq/log/sw_log/engine/
${Engine_logs_path}    cd /eniq/log/sw_log/engine    
${engine_showActive_command}    engine -e showActiveInterfaces
${engine_showdisable_sets}    engine -e showDisabledSets
${engine_restart}    engine -e restart
${engine_stop}    engine -e stop
${engine_start}    engine -e start
${engine_status_command}    engine -e status
${engine_disableset_techpack}    engine -e disableSet
${engine_enableset}    engine -e enableSet
${get_active_interfaces_01}    ./get_active_interfaces | grep -i
${get_active_interfaces_02}    ./get_active_interfaces | grep -i eniq_oss_2
${engine_startset_techpack}    engine -e startSet
${sql_query_Loader}    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Loader%');\ngo\n" | isql -P Etlrep12# -U etlrep -S repdb -b
${sql_query_Adapter}    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Adapter_INTF%');\ngo\n" | isql -P Etlrep12# -U etlrep -S repdb -b    


### Installer ###
@{list_of_active_services}    eniq-connectd.service    eniq-dwhdb.service    eniq-engine.service    eniq-esm.service    eniq-fls.service    eniq-licmgr.service    eniq-lwphelper.service    eniq-repdb.service    eniq-rmiregistry.service    eniq-scheduler.service    eniq-webserver.service
@{list_of_inactive_services}    eniq-dwh_reader.service    eniq-roll-snap.service
@{list_of_ALL_services}    NAS_ONLINE    ENGINE_PROFILE    CHECK_LOCKFILE    ENIQ_SERVICES    SSH_CHECK    DROP_LEAK    SNAPSHOT_CACHE_FS    SNAPSHOT_CACHE    OSS_MOUNT
@{list_of_SUCCESS_services}    NAS_ONLINE    ENGINE_PROFILE    ENIQ_SERVICES    SSH_CHECK    SNAPSHOT_CACHE_FS    SNAPSHOT_CACHE    CHECK_LOCKFILE    DROP_LEAK
@{list_of_FAILURE_services}    
@{list_of_WARNING_services}    OSS_MOUNT
${nfd}       lte
${eniq1}    eniq-connectd.service
${one_minute}    1MIN
${five_minute}    5MIN
${disable_OSS}    disable_OSS
${fls_restart}    fls restart
${rows_deleted}    deleted
${bin_folder}    cd /eniq/admin/bin
${Restart_command}     echo -e "Yes" | bash ./manage_deployment_services.bsh -a restart -s ALL
${system_services}     systemctl -t service | grep -i eniq
@{sub_dirs}    <subdir>dir1</subdir>    <subdir>dir2</subdir>    <subdir>dir3</subdir>    <subdir>dir4</subdir>    <subdir>dir5</subdir>
${Alarm_folder}     cd /eniq/log/sw_log/engine/AlarmInterfaces/
${Alarm_folder_2}    cd /eniq/log/sw_log/engine/DC_Z_ALARM/
${engine}    cd /eniq/log/sw_log/engine
${Alarm_folder}     cd /eniq/log/sw_log/engine/AlarmInterfaces/
${Alarm_folder_2}    cd /eniq/log/sw_log/engine/DC_Z_ALARM/
${IP_Addresss_folder}   cd /net/10.45.192.153/JUMP/ENIQ_STATS/
${ENIQ_STATS_folder}   cd ENIQ_STATS/23.2.8_Linux/eniq_base_sw/eniq_sw
${copy_runtime_module}     cp runtime_*.zip /eniq/sw/installer
${su_root}    su - root
${stop_all_services}    bash ./manage_deployment_services.bsh -a stop -s ALL
${dc_user}    su - dcuser
${installer_temp_folder}    rm -rf /eniq/sw/installer/temp
${make_directory}    mkdir /eniq/sw/installer/temp
${copy_module_into_installer_temp}    cp runtime_*.zip /eniq/sw/installer/temp
${unzip}    unzip runtime_*.zip
${chmod_insatll_runtime}    chmod u+x install_runtime.sh
${install_runtime}    ./install_runtime.sh
${checking_services_status}    systemctl -t service | grep -i eniq-
${start_all_services}    bash ./manage_deployment_services.bsh -a start -s ALL
${Linux_media_folder}    cd /net/10.45.192.153/JUMP/OM_LINUX_MEDIA/;ls -Art | grep -i OM_LINUX_| tail -1
${Linux_media_folder_02}    cd /net/10.45.192.153/JUMP/OM_LINUX_MEDIA/    
${security_folder}    /om_linux/security
${Linux_package_installation_command}    rpm -ivh /net/10.45.192.153/JUMP/OM_LINUX_MEDIA/OM_LINUX_023_2/23.2.8/om_linux/security/ERICnodehardening-R9D02.rpm
${node_hardening}    /ericsson/security/bin/Apply_Node_Hardening.py
${grep_node_hardening}    rpm -qa | grep ERICnodehardening
${eniq_stats_tp_folder}     cd /net/10.45.192.153/JUMP/ENIQ_STATS/ENIQ_STATS/
${list_folder}    ls
${linux_folder}     cd 23.2.7_Linux/eniq_base_sw/eniq_techpacks
${copy_techpack_to_installer_folder}    cp INTF_DIM_E_VPP_R2A_b2.tpi /eniq/sw/installer
${sw_installer}    cd /eniq/sw/installer
${install_techpack_command}    ./tp_installer -p . -t INTF_DIM_E_VPP_R2A_b2.tpi
${username_for_4036}    dcuser
${password_for_4036}    Eniq@4036
${port_for_4036}    2251
${host_4036}    atvts4036.athtem.eei.ericsson.se
${install_NR_events_techpack}     cp INTF_DC_E_NR_EVENTS_R4A_b4.tpi /eniq/sw/installer
${activate_NR_events_techpack}     ./activate_interface -o eniq_oss_1 -i INTF_DC_E_NR_EVENTS
${grep_eniq_oss_*}     ./get_active_interfaces | grep -i eniq_oss_*

### alarmcfg ###
${LOGIN_URL_alarm}    https://${SERVER_alarm}:${PORT_alarm}/alarmcfg
${LOGIN_URL_WITH_IP_alarm}    https://${SERVER IP_alarm}:${PORT_alarm}/alarmcfg
${WRONG_PORT_alarm}    8080
${WRONG_URL_alarm}    https://${SERVER_alarm}:${WRONG PORT_alarm}/alarmcfg
${SERVER_alarm}    ieatrcx8399.athtem.eei.ericsson.se
${PORT_alarm}    8443
${WRONG PORT_alarm}    8080
${SERVER IP_alarm}    10.45.199.105
${CMS NAME}    atclvm894:6400
${USERNAME_alarm}    eniq_alarm
${PASSWORD_alarm}    Test@12345
${AUTHENTICATION_alarm}    Enterprise
${Alarmcfg_folder}    /eniq/log/sw_log/alarmcfg/
${Alarm_password}    Eniq@1234
${DC_Z_Log_path}    /eniq/log/sw_log/engine/DC_Z_ALARM/
${alarm_interface_path}    /eniq/log/sw_log/engine/INTF_DC_Z_ALARM-eniq_oss_1
${latest_engine_file}    engine
${latest_Alarmcfg_file}    alarmcfg
${external_path}    /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/external/
${lib_path}    /eniq/sw/runtime/tomcat/webapps/alarmcfg/WEB-INF/lib/



### TPIDE ###
${Login_AdminUI_URL_teckpack}    https://ieatrcx8399.athtem.eei.ericsson.se:8443/techpackide/


### alarmcfg variables###
${login_almcfg_url}    https://${SERVER}.athtem.eei.ericsson.se:${PORT}/alarmcfg
${login_almcfg_invalid_port}  https://${SERVER}.athtem.eei.ericsson.se:${WRONG PORT}/alarmcfg
${login_almcfg_ip}    https://${pfserver_ip}:${PORT}/alarmcfg
${login_almcfg_ip_invalid_port}    https://${pfserver_ip}:${WRONG PORT}/alarmcfg
${pfserver_ip}    10.45.197.180
${incorrect_system}    ab
${incorrect_username}    ab
${incorrect_password}    ab
${incorrect_auth}    LDAP
${almcfg_sys}    ieatrcx4400:6400
${almcfg_user}    eniq_alarm
${almcfg_pass}    Test@12345
${almcfg_auth}    Enterprise
@{almcfg_time_list}    Reduced Delay    5min    10min    15min    30min    60min    6h    12h    24h    All
${almcfg_config_status}    True
${5min_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${5min_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${10min_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${10min_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${15min_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${15min_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${30min_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${30min_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${60min_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${60min_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${Reduced_delay_alm_template}    AUTOMATION ERBSG2 MPPROCESSINGRESOURCE RD TEST
${Reduced_delay_basetable}    DC_E_ERBSG2_MPPROCESSINGRESOURCE_RAW
${6h_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${6h_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${12h_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${12h_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${24h_alm_template}    AUTOMATION ERBSG2 PMULINTERFERENCEREPORT TEST
${24h_basetable}    DC_E_ERBSG2_PMULINTERFERENCEREPORT_RAW
${alarm_module}    alarm
${alarmcfg_module}    alarmcfg
${cdb_almcfg_sys}    atclvm858:6400
${cdb_almcfg_user}    eniq_alarm
${cdb_almcfg_pass}    Test@12345
${cdb_almcfg_auth}    Enterprise
${cdb_alm_template}    AUTOMATION_NR_GNBDUFUNCTION_TEST
${cdb_basetable}    DC_E_NR_GNBDUFUNCTION_RAW
${Reduced_delay_cdb_basetable}    DC_E_NR_NRCELLDU_RAW
${Reduced_delay_cdb_alm_template}    AUTOMATION_NR_NRCELLDU_RD_TEST   


##### Parser Variables ######
${Platform_path}    find /eniq/sw/platform/ -type f -name "*.zip" -printf "%f\n
${mws_path}    cd /net/10.45.192.153/JUMP/ENIQ_STATS/ENIQ_STATS/Features_23B_23.2.8_Linux/eniq_parsers
${install_parser_success_msg}    cat /eniq/log/sw_log/platform_installer/install_parser* | grep -i success
${install_3GPP32435_success_msg}    cat /eniq/log/sw_log/platform_installer/3GPP32435* | grep -i success
${install_3GPP32435BCS_success_msg}    cat /eniq/log/sw_log/platform_installer/3GPP32435BCS* | grep -i success
${install_3GPP32435DYN_success_msg}    cat /eniq/log/sw_log/platform_installer/3GPP32435DYN* | grep -i success
${install_HXMLCsIptnms_success_msg}    cat /eniq/log/sw_log/platform_installer/HXMLCsIptnms* | grep -i success
${install_HXMLPsIptnms_success_msg}    cat /eniq/log/sw_log/platform_installer/HXMLPsIptnms* | grep -i success
${install_MDC_success_msg}    cat /eniq/log/sw_log/platform_installer/MDC_DYN* | grep -i success
${install_MDC_CCN_success_msg}    cat /eniq/log/sw_log/platform_installer/MDC_CCN* | grep -i success
${install_MDC_DYN_success_msg}    cat /eniq/log/sw_log/platform_installer/MDC* | grep -i success
${install_MDC_PC_success_msg}    cat /eniq/log/sw_log/platform_installer/MDC_PC* | grep -i success
${install_TCIMParser_success_msg}    cat /eniq/log/sw_log/platform_installer/TCIMParser* | grep -i success
${install_ascii_success_msg}    cat /eniq/log/sw_log/platform_installer/ascii* | grep -i success
${install_asn1_success_msg}    cat /eniq/log/sw_log/platform_installer/asn1* | grep -i success
${install_bcd_success_msg}    cat /eniq/log/sw_log/platform_installer/bcd* | grep -i success
${install_common_success_msg}    cat /eniq/log/sw_log/platform_installer/common* | grep -i success
${install_nossdb_success_msg}    cat /eniq/log/sw_log/platform_installer/nossdb* | grep -i success               
${install_mrr_success_msg}    cat /eniq/log/sw_log/platform_installer/mrr* | grep -i success
${install_monitoring_success_msg}    cat /eniq/log/sw_log/platform_installer/monitoring* | grep -i success
${install_mlxml_success_msg}    cat /eniq/log/sw_log/platform_installer/mlxml* | grep -i success
${install_minilink_success_msg}    cat /eniq/log/sw_log/platform_installer/minilink* | grep -i success
${install_mediation_success_msg}    cat /eniq/log/sw_log/platform_installer/mediation* | grep -i success
${install_licensing_success_msg}    cat /eniq/log/sw_log/platform_installer/licensing* | grep -i success
${install_libs_success_msg}    cat /eniq/log/sw_log/platform_installer/libs* | grep -i success
${install_redback_success_msg}    cat /eniq/log/sw_log/platform_installer/redback* | grep -i success
${install_sasn_success_msg}    cat /eniq/log/sw_log/platform_installer/sasn* | grep -i success
${install_scheduler_success_msg}    cat /eniq/log/sw_log/platform_installer/scheduler* | grep -i success
${install_statlibs_success_msg}    cat /eniq/log/sw_log/platform_installer/statlibs* | grep -i success
${install_twampm_success_msg}    cat /eniq/log/sw_log/platform_installer/twampm* | grep -i success
${version_db_properties}    cat versiondb.properties | grep -w
${no_error_warning_execption_failed_notfound_null_incorrect}    warning\\|exception\\|invalid\\|not found\\|error\\|null\\|incorrect\\|failed    
${mws_path_list_of_features}    cd /net/10.45.192.153/JUMP/ENIQ_STATS/ENIQ_STATS/; ls -Art | grep Features_ | tail -1
${mws_path_list_of_modules}    cd /net/10.45.192.153/JUMP/ENIQ_STATS/ENIQ_STATS/
${install_kpiparser_success_msg}    cat /eniq/log/sw_log/platform_installer/kpiparser* | grep -i success    
${install_information_success_msg}    cat /eniq/log/sw_log/platform_installer/information_store_parser* | grep -i success
${install_ebs_success_msg}    cat /eniq/log/sw_log/platform_installer/ebs* | grep -i success
${install_eascii_success_msg}    cat /eniq/log/sw_log/platform_installer/eascii* | grep -i success
${install_ct_success_msg}    cat /eniq/log/sw_log/platform_installer/ct* | grep -i success
${install_twamppt_success_msg}    cat /eniq/log/sw_log/platform_installer/twamppt* | grep -i success    
${install_twampst_success_msg}    cat /eniq/log/sw_log/platform_installer/twampst* | grep -i success    
${install_volte_success_msg}    cat /eniq/log/sw_log/platform_installer/volte* | grep -i success
${install_csexport_success_msg}    cat /eniq/log/sw_log/platform_installer/csexport* | grep -i success
${install_xml_success_msg}    cat /eniq/log/sw_log/platform_installer/xml* | grep -i success
${install_json_success_msg}    cat /eniq/log/sw_log/platform_installer/json* | grep -i success
${install_stfiop_success_msg}    cat /eniq/log/sw_log/platform_installer/stfiop* | grep -i success
@{all_modules}    ^parser*    ^3GPP32435*    ^3GPP32435BCS*    ^3GPP32435DYN*    ^HXMLCsIptnms*    ^HXMLPsIptnms*    ^MDC_DYN*    ^MDC_CCN*    ^MDC_PC*    ^TCIMParser*    ^ascii*    ^asn1*    ^bcd*    ^nossdb*    ^mrr*    ^mlxml*    ^minilink*    ^ct*    ^redback*    ^sasn*    ^twampm*    ^twamppt*    ^twampst*    ^volte*    ^csexport*    ^ebs*    ^eascii*    ^xml*    ^json*    ^stfiop*
${Go_to_dcuser_folder}    cd /eniq/home/dcuser/
${epfg_permissions}    chmod -R 777 epfg
${revert_epfg_changes}    ./epfg_preconfig_for_ft.sh
${Go_to_config_folder}    cd config
${Go_to_epfg_folder}    cd epfg
${clearcase_url}     https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/

### License Module Variable ###
${license_folder}    cd /eniq/log/sw_log/licensemanager/
${latest_licensemanager_file}    licensemanager
${mws_paths}    /net/10.45.192.153/JUMP/
${ipv6_mws_paths}    /net/ieatrcx8190/JUMP/
${prompt}    [eniq_stats] {dcuser} #:

### DWHmanager variables ###
${dwh_green_status}    xpath://font[contains(text(),"ENIQ DWH")]/parent::td/preceding-sibling::td/img[@alt="Green"]
${change}    15

####Monitoring variables ####
${update_monitoring}    //a[contains(text(),"UpdateMonitoring")][1]

###### Installer Variables ####
${insatller_path_for_scripts}    /eniq/sw/installer/
${List_of_files}    ls /eniq/sw/installer/ | grep -i
${bin_path_for_scripts}    /eniq/sw/bin/
${List_of_files_bin}    ls /eniq/sw/bin/ | grep -i

##### FLS Variable ######
${module}    symboliclinkcreator
${symboliclink_folder}    cd /eniq/log/sw_log/symboliclinkcreator/
${latest_symboliclink_start_log_file}    start_fls
${latest_symboliclink_Delete_log_file}    DeleteSymlinkFile

