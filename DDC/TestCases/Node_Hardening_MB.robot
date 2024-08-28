*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            Collections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Library            RPA.FileSystem
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for node_hardening file in source
    [Documentation]       Checking for node_hardening_summary file in/ericsson/security/bin/ directory
    [Tags]                Node_Hardening
    Check File Exists     /ericsson/security/bin/node_hardening_summary.txt

Checking for node_hardening file size in source
    Depends on test       Checking for node_hardening file in source
    [Documentation]       Checking for non empty node_hardening_summary file in /ericsson/security/bin/ directory
    [Tags]                Node_Hardening
    Check File Size       /ericsson/security/bin/node_hardening_summary.txt

Checking for node_hardening file in destination
    Depends on test            Checking for node_hardening file size in source
    [Documentation]            Checking for node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory
    [Tags]                     Node_Hardening
    ${des_nh_log_file}=        Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening -name "node_hardening_*-${hostname}-*.json"
    Set Global Variable        ${des_nh_log_file}
    Check File Exists          ${des_nh_log_file}

Checking for node_hardening file size in destination
    Depends on test       Checking for node_hardening file in destination
    [Documentation]       Checking for non empty node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory
    [Tags]                Node_Hardening
    Check File Size       ${des_nh_log_file}

Checking for node_hardening file in engine destination
    Depends on test               Checking for node_hardening file in source
    [Documentation]               Checking for node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory from Engine Blade
    [Tags]                        Node_Hardening
    ${engine_nh_log_file}=        Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening -name "node_hardening_*-${hostname_engine}-*.json"
    Set Global Variable           ${engine_nh_log_file}
    Check File Exists             ${engine_nh_log_file}

Checking for node_hardening file size in engine destination
    Depends on test       Checking for node_hardening file in engine destination
    [Documentation]       Checking for non empty node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory from Engine Blade
    [Tags]                Node_Hardening
    Check File Size       ${engine_nh_log_file}

Checking for node_hardening file in reader_1 destination
    Depends on test                Checking for node_hardening file in source
    [Documentation]                Checking for node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory from Reader_1 Blade
    [Tags]                         Node_Hardening
    ${reader1_nh_log_file}=        Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening -name "node_hardening_*-${hostname_reader_1}-*.json"
    Set Global Variable            ${reader1_nh_log_file}
    Check File Exists              ${reader1_nh_log_file}

Checking for node_hardening file size in reader_1 destination
    Depends on test       Checking for node_hardening file in reader_1 destination
    [Documentation]       Checking for non empty node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory from Reader_1 Blade
    [Tags]                Node_Hardening
    Check File Size       ${reader1_nh_log_file}

Checking for node_hardening file in reader_2 destination
    Depends on test               Checking for node_hardening file in source
    [Documentation]               Checking for node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory from Reader_2 Blade
    [Tags]                        Node_Hardening
    ${reader2_nh_log_file}=       Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening -name "node_hardening_*-${hostname_reader_2}-*.json"
    Set Global Variable           ${reader2_nh_log_file}
    Check File Exists             ${reader2_nh_log_file}

Checking for node_hardening file size in reader_2 destination
    Depends on test       Checking for node_hardening file in reader_2 destination
    [Documentation]       Checking for non empty node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory from Reader_2 Blade
    [Tags]                Node_Hardening
    Check File Size       ${reader2_nh_log_file}
