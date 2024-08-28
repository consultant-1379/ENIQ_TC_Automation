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
Checking for node_hardening file in source TC01
    [Documentation]       Checking for node_hardening_summary file in/ericsson/security/bin/ directory
    [Tags]                Node_Hardening
    Check File Exists     /ericsson/security/bin/node_hardening_summary.txt

Checking for node_hardening file size in source TC02
    Depends on test       Checking for node_hardening file in source TC01
    [Documentation]       Checking for non empty node_hardening_summary file in /ericsson/security/bin/ directory
    [Tags]                Node_Hardening
    Check File Size       /ericsson/security/bin/node_hardening_summary.txt

Checking for node_hardening file in destination TC03
    Depends on test            Checking for node_hardening file size in source TC02
    [Documentation]            Checking for node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory
    [Tags]                     Node_Hardening
    Count Of Files             /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening
    Log To Console             ${count}
    IF    ${count} == 1
        ${des_nh_log_file}=        Execute Command    ls -lrth /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening | awk '/Full/ || /Granular/ || /_-/ {print $9}'
        Set Global Variable        ${des_nh_log_file}
        Check File Exists          /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening/${des_nh_log_file}
    ELSE IF   ${count}>1
        ${des_nh_log_file}=        Execute Command    ls -lrth /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening | awk '/Full/ || /Granular/ {print $9}' | tail -1
        Set Global Variable        ${des_nh_log_file}
        Check File Exists          /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening/${des_nh_log_file}
    ELSE
        Fail  No file is present.
    END

Checking for node_hardening file size in destination TC04
    Depends on test       Checking for node_hardening file in destination TC03
    [Documentation]       Checking for non empty node_hardening_summary file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening directory
    [Tags]                Node_Hardening
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/node_hardening/${des_nh_log_file}