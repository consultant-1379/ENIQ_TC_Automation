*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking CheckedTables file and size in source TC01
    [Documentation]      Checking for ${src_output_variable} file in /eniq/log/sw_log/iq/DbCheckLogs directory
    [Tags]               DBCC_CheckedTables
    ${src_output_variable}=     Execute Command    find /eniq/log/sw_log/iq/DbCheckLogs -name "CheckedTables_${curr_date_d.m.y}_*.log" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 7- | tail -n 1
    Set Global Variable     ${src_output_variable}
    ${src_check_table}=     Run Keyword And Return Status    Check File Exists    /eniq/log/sw_log/iq/DbCheckLogs/${src_output_variable}
    Set Global Variable           ${src_check_table}
    IF    ${src_check_table} == True
    ${src_check_table_size}=    Check File Size New      /eniq/log/sw_log/iq/DbCheckLogs/${src_output_variable}
    Set Global Variable    ${src_check_table_size}
    Run Keyword If   ${src_check_table_size}==0   Fail    Size is zero.
    ELSE
        Skip   Checked Table log not having size in the source path
    END

Checking CheckedTables file and size in destination TC02
    Skip If    ${src_check_table} == False
    Depends on test      Checking CheckedTables file and size in source TC01
    [Documentation]      Checking for ${src_output_variable} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]               DBCC_CheckedTables
    ${des_output_variable}=         Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check -name "CheckedTables_${curr_date_d.m.y}_*.log" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 9- | tail -n 1
    Set Global Variable             ${des_output_variable}
    ${des_check_table}=             Run Keyword And Return Status    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/${des_output_variable}
    Set Global Variable             ${des_check_table}
    IF    ${des_check_table} == True
    ${des_check_table_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/${des_output_variable}
    Set Global Variable    ${des_check_table_size}
    Run Keyword If   ${des_check_table_size}==0    Fail     Size is zero.
    ELSE
        Fail   Checked Table log not having size in the source path
    END

Checking Cron_dbcc_log file and size in source TC03
    [Documentation]           Checking for Cron_dbcc_log file and size in /eniq/log/sw_log/iq/DbCheckLogs directory
    [Tags]                    DBCC_Cron_dbcc_log
    ${cron_src_variable}=     Execute Command    find /eniq/log/sw_log/iq/DbCheckLogs -name "${hostname}_cron_dbcc_log_${curr_date_y-b-d}_*" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 7- | tail -n 1
    Set Global Variable       ${cron_src_variable}
    ${check_cron_log}=     Run Keyword And Return Status    Check File Exists         /eniq/log/sw_log/iq/DbCheckLogs/${cron_src_variable}
    Set Global Variable    ${check_cron_log}
    Log To Console    ${check_cron_log}
    IF    ${check_cron_log} == True
    ${src_cron_size}=    Check File Size New      /eniq/log/sw_log/iq/DbCheckLogs/${cron_src_variable}
    Set Global Variable    ${src_cron_size}
    Run Keyword If   ${src_cron_size}==0   Fail    Size is zero.
    ELSE
        Skip   cron log not having size in the source path
    END

Checking Cron_dbcc_log file and size in destination TC04
    Skip If    ${check_cron_log} == False
    Depends on test           Checking Cron_dbcc_log file and size in source TC03
    [Documentation]           Checking for ${cron_src_variable} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]                    DBCC_Cron_dbcc_log
    ${cron_des_variable}=     Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check -name "${hostname}_cron_dbcc_log_${curr_date_y-b-d}_*" -printf "%T@ %p\n" -ls | sort -n | cut -d'/' -f 9- | tail -n 1
    Set Global Variable       ${cron_des_variable}
    ${check_cron_des_log}=     Run Keyword And Return Status    Check File Exists         /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/${cron_des_variable}
    Set Global Variable    ${check_cron_des_log}
    Log To Console    ${check_cron_des_log}
    IF    ${check_cron_des_log} == True
    ${des_cron_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/${cron_des_variable}
    Set Global Variable    ${des_cron_size}
    Run Keyword If   ${des_cron_size}==0   Fail    Size is zero.
    ELSE
        Fail   cron log not having size in the destination path
    END

Checking IndexError file and size in source TC05
    [Documentation]      Checking for IndexError.log file in /eniq/log/sw_log/iq/DbCheckLogs directory
    [Tags]               DBCC_IndexError
    ${check_src_index_log}=     Run Keyword And Return Status     Check File Exists    /eniq/log/sw_log/iq/DbCheckLogs/IndexError.log
    Set Global Variable    ${check_src_index_log}
    Log To Console    ${check_src_index_log}
    IF    ${check_src_index_log} == True
    ${src_index_size}=    Check File Size New      /eniq/log/sw_log/iq/DbCheckLogs/IndexError.log
    Set Global Variable    ${src_index_size}
    Run Keyword If   ${src_index_size}==0   Fail    Size is zero.
    ELSE
        Skip   IndexError file and size is not there in the source path
    END

Checking IndexError file and size in destination TC06
    Skip If    ${check_src_index_log} == False
    Depends on test      Checking IndexError file and size in source TC05
    [Documentation]      Checking for IndexError.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]               DBCC_IndexError
    ${check_des_index_log}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/IndexError.log
    Set Global Variable    ${check_des_index_log}
    Log To Console    ${check_des_index_log}
    IF    ${check_des_index_log} == True
    ${des_index_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/IndexError.log
    Set Global Variable    ${des_index_size}
    Run Keyword If   ${des_index_size}==0   Fail    Size is zero.
    ELSE
        Fail   IndexError file and size is not there in the destination path
    END

Checking SecondLevelCheckTable file and size in source TC07
    [Documentation]      Checking for SecondLevelCheckTable.log file in /eniq/log/sw_log/iq/DbCheckLogs directory
    [Tags]               DBCC_SecondLevelCheckTable
    ${src_secondcheck}=     Run Keyword And Return Status     Check File Exists    /eniq/log/sw_log/iq/DbCheckLogs/SecondLevelCheckTable.log
    Set Global Variable    ${src_secondcheck}
    Log To Console    ${src_secondcheck}
    IF    ${src_secondcheck} == True
    ${src_secondcheck_size}=    Check File Size New      /eniq/log/sw_log/iq/DbCheckLogs/SecondLevelCheckTable.log
    Set Global Variable    ${src_secondcheck_size}
    Run Keyword If   ${src_secondcheck_size}==0   Fail    Size is zero.
    ELSE
        Skip   SecondLevelCheckTable file and file size is not there in the source path
    END

Checking SecondLevelCheckTable file and size in destination TC08
    Skip If    ${src_secondcheck} == False
    Depends on test      Checking SecondLevelCheckTable file and size in source TC07
    [Documentation]      Checking for SecondLevelCheckTable.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]               DBCC_SecondLevelCheckTable
    ${des_secondcheck}=    Run Keyword And Return Status    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/SecondLevelCheckTable.log
    Set Global Variable    ${des_secondcheck}
    Log To Console    ${des_secondcheck}
    IF    ${des_secondcheck} == True
    ${des_secondcheck_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/SecondLevelCheckTable.log
    Set Global Variable    ${des_secondcheck_size}
    Run Keyword If   ${des_secondcheck_size}==0   Fail    Size is zero.
    ELSE
        Fail   SecondLevelCheckTable file and file size is not there in the destination path
    END

Checking NotCheckedTables file and size in source TC09
    [Documentation]      Checking for NotCheckedTables.log file in /eniq/log/sw_log/iq/DbCheckLogs directory
    [Tags]               DBCC_NotCheckedTables
    ${src_notchecktable}=     Run Keyword And Return Status     Check File Exists    /eniq/log/sw_log/iq/DbCheckLogs/NotCheckedTables.log
    Set Global Variable    ${src_notchecktable}
    Log To Console    ${src_notchecktable}
    IF    ${src_notchecktable} == True
    ${src_notchecktable_size}=    Check File Size New      /eniq/log/sw_log/iq/DbCheckLogs/NotCheckedTables.log
    Set Global Variable    ${src_notchecktable_size}
    Run Keyword If   ${src_notchecktable_size}==0   Fail    Size is zero.
    ELSE
        Skip   NotCheckedTable file and size is not there in the source path
    END

Checking NotCheckedTables file and size in destination TC10
    Skip If    ${src_notchecktable} == False
    Depends on test      Checking NotCheckedTables file and size in source TC09
    [Documentation]      Checking for NotCheckedTables.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]               DBCC_NotCheckedTables
    ${des_notchecktable}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/NotCheckedTables.log
    Set Global Variable    ${des_notchecktable}
    Log To Console    ${des_notchecktable}
    IF    ${des_notchecktable} == True
    ${des_notchecktable_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/NotCheckedTables.log
    Set Global Variable    ${des_notchecktable_size}
    Run Keyword If   ${des_notchecktable_size}==0   Fail    Size is zero.
    ELSE
        Fail   NotCheckedTable file and size is not there in the destination path
    END

Checking dbcheck file and size in source TC11
    [Documentation]      Checking for dbcheck.env file in /eniq/admin/etc directory
    [Tags]               DBCC_dbcheck
    ${src_dbcheck}=     Run Keyword And Return Status     Check File Exists    /eniq/admin/etc/dbcheck.env
    Set Global Variable    ${src_dbcheck}
    Log To Console    ${src_dbcheck}
    IF    ${src_dbcheck} == True
    ${src_dbcheck_size}=    Check File Size New      /eniq/admin/etc/dbcheck.env
    Set Global Variable    ${src_dbcheck_size}
    Run Keyword If   ${src_dbcheck_size}==0   Fail    Size is zero.
    ELSE
        Skip   dbcheck file ans size is not there in the source path
    END

Checking dbcheck file and size in destination TC12
    Skip If    ${src_dbcheck} == False
    Depends on test      Checking dbcheck file and size in source TC11
    [Documentation]      Checking for dbcheck.env file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]               DBCC_dbcheck
    ${des_dbcheck}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/dbcheck.env
    Set Global Variable    ${des_dbcheck}
    Log To Console    ${des_dbcheck}
    IF    ${des_dbcheck} == True
    ${des_dbcheck_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/dbcheck.env
    Set Global Variable    ${des_dbcheck_size}
    Run Keyword If   ${des_dbcheck_size}==0   Fail    Size is zero.
    ELSE
        Fail   dbcheck file ans size is not there in the destination path
    END

Checking NotVerifiedIndex file and size in source TC13
    [Documentation]      Checking for NotVerifiedIndex.log file in /eniq/log/sw_log/iq/DbCheckLogs directory
    [Tags]               DBCC_NotVerifiedIndex
    ${src_notverified}=     Run Keyword And Return Status    Check File Exists    /eniq/log/sw_log/iq/DbCheckLogs/NotVerifiedIndex.log
    Set Global Variable    ${src_notverified}
    Log To Console    ${src_notverified}
    IF    ${src_notverified} == True
    ${src_notverified_size}=    Check File Size New      /eniq/log/sw_log/iq/DbCheckLogs/NotVerifiedIndex.log
    Set Global Variable    ${src_notverified_size}
    Run Keyword If   ${src_notverified_size}==0   Fail    Size is zero.
    ELSE
        Skip   NotVerifiedIndex file and size is not there in the source path
    END

Checking NotVerifiedIndex file in destination TC14
    Skip If    ${src_notverified} == False
    Depends on test      Checking NotVerifiedIndex file and size in source TC13
    [Documentation]      Checking for NotVerifiedIndex.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check directory
    [Tags]               DBCC_NotVerifiedIndex
    ${des_notverified}=     Run Keyword And Return Status        Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/NotVerifiedIndex.log
    Set Global Variable    ${des_notverified}
    Log To Console    ${des_notverified}
    IF    ${des_notverified} == True
    ${des_notverified_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/database_consistency_check/NotVerifiedIndex.log
    Set Global Variable    ${des_notverified_size}
    Run Keyword If   ${des_notverified_size}==0   Fail    Size is zero.
    ELSE
        Fail   NotVerifiedIndex file and size is not there in the source path
    END
