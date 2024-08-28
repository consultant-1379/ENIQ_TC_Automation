*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for sapiq_large_memory file in SAP IQ source
    [Documentation]           Checking for sapiq_large_memory_${date_Y-m-d}.txt file in /eniq/log/assureddc/sapIqLargeMemory directory
    [Tags]                    SAP_IQ
    Check File Exists         /eniq/log/assureddc/sapIqLargeMemory/sapiq_large_memory_${date_Y-m-d}.txt

Checking for sapiq_large_memory file size in SAP IQ source
    Depends on test               Checking for sapiq_large_memory file in SAP IQ source
    [Documentation]               Checking for non empty sapiq_large_memory_${date_Y-m-d}.txt file in /eniq/log/assureddc/sapIqLargeMemory directory from dwh_reader_2 Blade
    [Tags]                        SAP_IQ
    Check File Size               /eniq/log/assureddc/sapIqLargeMemory/sapiq_large_memory_${date_Y-m-d}.txt

Checking for sapiq_query file in SAP IQ source
    [Documentation]       Checking for sapiq_query_file.sql  in /eniq/log/assureddc/sapIqLargeMemory directory
    [Tags]                SAP_IQ
    Check File Exists     /eniq/log/assureddc/sapIqLargeMemory/sapiq_query_file.sql

Checking for sapiq_query file size in SAP IQ source
    Depends on test                 Checking for sapiq_query file in SAP IQ source
    [Documentation]                 Checking for non empty sapiq_query_file.sql file in /eniq/log/assureddc/sapIqLargeMemory directory
    [Tags]                          SAP_IQ
    Check File Size                 /eniq/log/assureddc/sapIqLargeMemory/sapiq_query_file.sql

Checking for sapiq_large_memory file in SAP IQ destination
    Depends on test       Checking for sapiq_query file size in SAP IQ source
    [Documentation]       Checking for sapiq_large_memory_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sapIqLargeMemory directory
    [Tags]                SAP_IQ
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sapIqLargeMemory/sapiq_large_memory_${date_Y-m-d}.txt

Checking for sapiq_large_memory file size in SAP IQ destination
    Depends on test       Checking for sapiq_large_memory file in SAP IQ destination
    [Documentation]       Checking for non empty sapiq_large_memory_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sapIqLargeMemory directory
    [Tags]                SAP_IQ
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sapIqLargeMemory/sapiq_large_memory_${date_Y-m-d}.txt

Checking for iq_version file in SAP IQ source
    [Documentation]       Checking for iq_version in /eniq/sybase_iq/version directory
    [Tags]                SAP_IQ
    Check File Exists     /eniq/sybase_iq/version/iq_version

Checking for iq_version file size in SAP IQ source
    Depends on test       Checking for iq_version file in SAP IQ source
    [Documentation]       Checking for non empty iq_version file in /eniq/sybase_iq/version directory
    [Tags]                SAP_IQ
    Check File Size       /eniq/sybase_iq/version/iq_version

Checking for iq_version file in SAP IQ destination
    Depends on test       Checking for iq_version file size in SAP IQ source
    [Documentation]       Checking for iq_version file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq directory
    [Tags]                SAP_IQ
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq/iq_version

Checking for iq_version file size in SAP IQ destination
    Depends on test       Checking for iq_version file in SAP IQ destination
    [Documentation]       Checking for non empty iq_version file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq directory
    [Tags]                SAP_IQ
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq/iq_version

Checking Sybase_IQ file in source
    [Documentation]            Checking for Sybase_IQ file in /tmp directory
    [Tags]                     SAP_IQ
    ${src_sapIq_log_file}=     Execute Command    find /tmp -name "sybaseIQ_instr_${date_Y-m-d}.txt"
    Set Global Variable        ${src_sapIq_log_file}
    Check File Exists          ${src_sapIq_log_file}

Checking Sybase_IQ file size in source
    Depends on test      Checking Sybase_IQ file in source
    [Documentation]      Checking for non empty Sybase_IQ file in /tmp directory
    [Tags]               SAP_IQ
    Check File Size      ${src_sapIq_log_file}

Checking Sybase_IQ file in destination
    Depends on test            Checking Sybase_IQ file size in source
    [Documentation]            Checking for Sybase_IQ file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq directory
    [Tags]                     SAP_IQ
    ${des_sapIq_log_file}=     Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq -name "sybaseIQ_instr_${date_Y-m-d}.txt"
    Set Global Variable        ${des_sapIq_log_file}
    Check File Exists          ${des_sapIq_log_file}

Checking Sybase_IQ file size in destination
    Depends on test      Checking Sybase_IQ file in destination
    [Documentation]      Checking for non empty Sybase_IQ file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sybase_iq directory
    [Tags]               SAP_IQ
    Check File Size      ${des_sapIq_log_file}