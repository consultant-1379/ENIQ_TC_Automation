*** Settings ***
Library    SSHLibrary
Test Setup          Open Connection And Log In
Test Teardown       Close All Connections
Library    DIM_E_GRAN.py
Library    String
Library    RPA.RobotLogListener


*** Variables ***
${host}    atvts4134.athtem.eei.ericsson.se
${port}    2251
${uname}     dcuser
${pwd}       Dcuser%12
${password_db}      Dwhrep12#
${username}      dwhrep
${database}      repdb
${run}		go
${dwhdb_pwd}      Dc12#
${dwhdb_username}      dc
${dwhdb_database}      dwhdb
${package}    DC_E_CCRC
${dim_pkg}    DIM_E_GRAN

    
*** Keywords ***
Open Connection and Log In
    
    ${index}    Open Connection    ${host}    port=${port}    timeout=10
    Login    ${uname}    ${pwd}

Verify the NREL table
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Write    cd /eniq/home/dcuser
        Read    delay=2s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "Select NEIGHBORCELL,OSS_ID,NEIGHBORBSC from DIM_E_GRAN_NETOP_CELL_NREL where neighborBsc!=''\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${nrel_output}=    Read Until Prompt
        Set Global Variable    ${nrel_output}
        Log To Console    {\n}    ${nrel_output}
        Write    echo -e "select CELL_NAME,OSS_ID,BSC_NAME from DIM_E_GRAN_CELL\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${cell_output}=    Read Until Prompt
        Set Global Variable    ${cell_output}
        Log To Console    {\n}    ${cell_output}
        ${flag}    ${message}    DIM_E_GRAN.NREL Filter    ${nrel_output}    ${cell_output}
        IF    ${flag}==1
            Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
        END
    END

Verify the CELL table
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select distinct OSS_ID,BSC_NAME,CELL_BAND,CELL_ID,CELL_LAYER,CELL_NAME,CELL_TYPE,FPDCH,LAC,MCC,MNC,MSC,SITE_NAME,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_CELL\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${cell_output2}=    Read     delay=5
        Set Global Variable    ${cell_output2}
        Log To Console    {\n}    ${cell_output2}
        Write    echo -e "Select distinct OSS_ID,BSC_NAME,CELL_BAND,CELL_ID,CELL_LAYER,CELL_NAME,CELL_TYPE,FPDCH,LAC,MCC,MNC,MSC,SITE_NAME,VENDOR,STATUS,CREATED,MODIFIED,MODIFIER from DIM_E_GRAN_NETOP_CELL\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${netop_cell_output}=    Read    delay=5
        Set Global Variable    ${netop_cell_output}
        Log To Console    {\n}    ${netop_cell_output}
        ${flag}    ${message}     DIM_E_GRAN.Compare Cell And Netop Cell    ${cell_output2}    ${netop_cell_output}
        IF    ${flag}==1
            Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
            
        END
    END
    
Verify the BSCTRC table
    IF    '${dim_pkg}' == 'DIM_E_GRAN'
        Write    cd /eniq/home/dcuser
        Read    delay=2s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select BSC_TYPE,OSS_ID,BSC_ID,BSC_FDN,BSC_NAME,BSC_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS from DIM_E_GRAN_BSC\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${BSC_OUTPUT}=    Read Until Prompt
        Set Global Variable    ${BSC_OUTPUT}
        Log To Console    {\n}    ${BSC_OUTPUT}
        Write    echo -e "select TRC_TYPE,OSS_ID,TRC_ID,TRC_FDN,TRC_NAME,TRC_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS from DIM_E_GRAN_TRC\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${TRC_OUTPUT}=    Read Until Prompt
        Set Global Variable    ${TRC_OUTPUT}
        Log To Console    {\n}    ${TRC_OUTPUT}
        Write    echo -e "select NE_TYPE,OSS_ID,NE_ID,NE_FDN,NE_NAME,NE_VERSION,SITE,SITE_FDN,SOURCE_FILE,SOURCE_TYPE,SUBNETWORK1,SUBNETWORK2,TRX,VENDOR,STATUS from DIM_E_GRAN_BSCTRC\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${BSCTRC_OUTPUT}=    Read Until Prompt
        Set Global Variable    ${BSCTRC_OUTPUT}
        Log To Console    {\n}    ${BSCTRC_OUTPUT}
        ${flag}    ${message}    DIM_E_GRAN.Compare Bsctrc    ${BSC_OUTPUT}    ${TRC_OUTPUT}    ${BSCTRC_OUTPUT}
        IF    ${flag}==1
        Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
            
        END
    END
    
Verify the loading with multiple MOIDS
    IF    '${package}' == 'DC_E_CCRC'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Put File    H:/Automation_work/ENIQ_TC_Automation/KPI/Daily_work/Ravi/epfg_ccrc.pl   /eniq/home/dcuser
        DIM_E_GRAN.Edit Epfg For NFMGroupMultiMeasObjLdn    ${host}    ${port}    ${uname}    ${pwd}
        Write     cd /eniq/home/dcuser ; echo -e "${package}_R10A_b12.tpi" | perl epfg_ccrc.pl 
        ${out}=    Read Until Prompt
        Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
        ${out}=    Read Until Prompt
        Sleep    180
        Write    engine -e startSet 'INTF_DC_E_CCRC-eniq_oss_1' 'Adapter_INTF_DC_E_CCRC_3gpp32435'
        ${out}=    Read Until Prompt
        Should Contain    ${out}    Start set requested successfully    Failed starting Adapter set for INTF_DC_E_CCRC-eniq_oss_1
    
        Write    cd /eniq/home/dcuser
        Read    delay=2s
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    echo -e "select moid from DC_E_CCRC_NRF_NNRF_NFM_RAW\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${ccrc_moid_output}=    Read Until Prompt
        Set Global Variable    ${ccrc_moid_output}
        Log To Console    {\n}    ${ccrc_moid_output}
        Write    echo -e "select operation,remote_endpoint,status_code from DC_E_CCRC_NRF_NNRF_NFM_RAW\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
        ${ccrc_moid_val_output}=    Read Until Prompt
        Set Global Variable    ${ccrc_moid_val_output}
        Log To Console    {\n}    ${ccrc_moid_val_output}
        ${flag}    ${message}    DIM_E_GRAN.Ccrc Moid    ${ccrc_moid_output}    ${ccrc_moid_val_output}
        IF    ${flag}==1
            Log    ${\n}${message}
        ELSE
            Fail    Testcase Failed as ${message}
        END
    END

Verify the Start and Stop Time values
    IF    '${package}' == 'DC_E_NETOP'
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
        Write    cd /eniq/home/dcuser
        Read    delay=5s
        Write    echo -e "select TYPEID from MeasurementTable WHERE MTABLEID like'%DC_E_NETOP%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
        ${repdb_table_output}=    Read Until Prompt
        ${bar}    ${mrr}    DIM_E_GRAN.Verify Netop Start And Stop Time    ${repdb_table_output}
        ${NETOP_BAR_file_name}    Execute Command     cd /ericsson/pmic1/pm_storage/NCS_ASCII/BAA01/ && ls
        ${filter_bar file_name}    DIM_E_GRAN.Verify Netop Start And Stop Time1    ${NETOP_BAR_file_name}
        ${fileid_bar}    Split String From Right    ${filter_bar file_name}    _
        Log    ${\n}${fileid_bar}[-1]
        ${read_bar_file}    Execute Command    cat /ericsson/pmic1/pm_storage/NCS_ASCII/BAA01/${filter_bar file_name} | grep -e 'Start date' -e 'Start time' -e 'RECTIME:' | sort --unique
        Log    ${\n}${read_bar_file}
        FOR    ${bar_table}    IN    @{bar}
            Log To Console    ${bar_table}
            Write    echo -e "select Recording_Start_time,Recording_Stop_time from ${bar_table}_RAW where BSC_Node_Name='BAA01' and FILE_ID='${fileid_bar}[-1]'\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
            ${bar_table_output}    Read Until Prompt
            ${bar_table_query_output}    DIM_E_GRAN.Verify Netop Start And Stop Time2    ${read_bar_file}    ${bar_table_output}
            IF    ${bar_table_query_output} == 1
                Log    PASS
            ELSE
                Fail    Value are not matching
                
            END

        END
        ${NETOP_MRR_file_name}    Execute Command     cd /ericsson/pmic1/pm_storage/MRR_ASCII/BAA01/ && ls
        ${filter_mrr_file_name}    DIM_E_GRAN.Verify Netop Start And Stop Time1    ${NETOP_MRR_file_name}
        ${fileid_mrr}    Split String From Right    ${filter_mrr_file_name}    _
        Log    ${\n}${fileid_mrr}[-1]
        ${read_mrr_file}    Execute Command    cat /ericsson/pmic1/pm_storage/MRR_ASCII/BAA01/${filter_mrr_file_name} | grep -e 'Start date' -e 'Start time' -e 'Total time recording:' | sort --unique
        Log    ${\n}${read_mrr_file}
        FOR    ${mrr_table}    IN    @{mrr}
            Log To Console    ${mrr_table}
            Write    echo -e "select Recording_Start_time,Recording_Stop_time from ${mrr_table}_RAW where BSC_Node_Name='BAA01' and FILE_ID='${fileid_mrr}[-1]'\\n${run}\\n" | isql -P ${dwhdb_pwd} -U ${dwhdb_username} -S ${dwhdb_database} -b
            ${mrr_table_output}    Read Until Prompt
            ${mrr_table_query_output}    DIM_E_GRAN.Verify Netop Start And Stop Time3    ${read_mrr_file}    ${mrr_table_output}
            IF    ${mrr_table_query_output} == 1
                Log    PASS
            ELSE
                Fail    Value are not matching
                
            END

        END
    END

*** Test Cases ***
Testcas1
    Verify the NREL table
Testcase2
    Verify the CELL table

Testcase3
    Verify the BSCTRC table
Testcase4
    Verify the loading with multiple MOIDS

Testcase5
    Verify the Start and Stop Time values