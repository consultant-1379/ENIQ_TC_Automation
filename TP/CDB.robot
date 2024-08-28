*** Settings ***
Library           SSHLibrary
Library    String
*** Variables ***
${HOSTNAME}    atvts4110
${Patch_Media}    JUMP/INSTALL_PATCH_MEDIA/12/RHEL/RHEL7.9-3.0.20
${release}    ENIQ_S23.2
${version}    23.2.7
${test_variable}    COUNTER_AND_KEYS_VALIDATION: PASS- 0 FAIL- 10PARTIAL FILE: /eniq/home/dcuser/RegressionLogs/COUNTER_AND_KEYS_VALIDATION_20230405103303.html
*** Tasks ***
TP - ENIQ_TP_UG_TC208 Running rt suite
    Open Connection    seliius26954.seli.gic.ericsson.se      
    Login    eniqdmt    EStAts(iDec$2()18
    ${out1}=    Execute Command    /usr/atria/bin/cleartool setview -login -exec "/vobs/ossrc/del-mgt/bin/ES_RT_MWS_PATH_Update_linux.pl -pp 23.2.7_Linux -fp Features_23B_23.2.7_Linux -rp ${Patch_Media} -m '${HOSTNAME}' -ip 10.45.192.134" eniq_dmstats_ci    output_during_execution=True
    ${out2}=    Execute Command    /usr/atria/bin/cleartool setview -login -exec "python /vobs/ossrc/del-mgt/bin/Copy_RT_pkg.py ENIQ_S23.2 23.2.7 '${HOSTNAME}'" eniq_dmstats_ci    output_during_execution=True
    ${out3}=    Execute Command    /usr/atria/bin/cleartool setview -login -exec "/vobs/ossrc/del-mgt/bin/Eniq_Stats_CDB_RT_linux_nes1.pl -r '${release}' -s '${version}' -m ${HOSTNAME}" eniq_dmstats_ci    output_during_execution=True
    Close All Connections  
    Sleep    11h
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep -E -i '^(-+END-+)'
    IF    '${out}' == ''
        Sleep    1h
    END
TP - ENIQ_TP_UG_TC89 COUNTER_AND_KEYS_VALIDATION
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep COUNTER_AND_KEYS_VALIDATION:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC85 ADMINUI_DATAROW_SHOWREF
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep ADMINUI_DATAROW_SHOWREF:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC103,TP - ENIQ_TP_UG_TC104 BUSY_HOUR_COUNT
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep BUSY_HOUR_COUNT:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC30 ADMINUI_PLATFORM_CHECKS
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep ADMINUI_PLATFORM_CHECKS:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC209 Universe_and_Alarm_Report_Verification
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep Universe_and_Alarm_Report_Verification:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC210 Sanity_Directory_Scripts_Check
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep Sanity_Directory_Scripts_Check:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC211 COMPAREBASELINE_VERIFICATION
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep COMPAREBASELINE_VERIFICATION:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC51 VERIFY_TOPOLOGY_TABLES
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep VERIFY_TOPOLOGY_TABLES:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC86 VERIFY_DATA_LOADING
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep VERIFY_DATA_LOADING:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC36 Log_Verification
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep Log_Verification:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC36 Engine_Subdirs_Log_Verification
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep Engine_Subdirs_Log_Verification:
    Should Contain    ${out}    FAIL- 0
TP - ENIQ_TP_UG_TC36 TP_Installer_Log_Verification
    Open Connection    host=${HOSTNAME}.athtem.eei.ericsson.se    port=2251
    Login    dcuser    Dcuser%12
    ${out}=    Execute Command    cd eniq/home/dcuser ; cat nohup.out | grep TP_Installer_Log_Verification:
    Should Contain    ${out}    FAIL- 0

