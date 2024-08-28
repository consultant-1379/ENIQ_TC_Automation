*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for diagnostic file and size in IQ Diagnostic source TC01
    [Documentation]      Checking for ${date_Y-m-d}_diagnostic.tar.gz file and size in /eniq/log/sw_log/iq/iq_diag directory
    [Tags]               IQ_Diagnostic
    ${src_iq_diag}=     Run Keyword And Return Status    Check File Exists    /eniq/log/sw_log/iq/iq_diag/${date_Y-m-d}_diagnostic.tar.gz
    Set Global Variable    ${src_iq_diag}
    Log To Console    ${src_iq_diag}
    IF    ${src_iq_diag} == True
    ${src_iq_diag_size}=    Check File Size New      /eniq/log/sw_log/iq/iq_diag/${date_Y-m-d}_diagnostic.tar.gz
    Set Global Variable    ${src_iq_diag_size}
    Run Keyword If   ${src_iq_diag_size}==0   Fail    Size is zero.
    ELSE
        Skip   ${date_Y-m-d}_diagnostic.tar.gz log and size is not there in the source path
    END

Checking for diagnostic file in IQ Diagnostic destination TC02
    Skip If    ${src_iq_diag} == False
    Depends on test      Checking for diagnostic file and size in IQ Diagnostic source TC01
    [Documentation]      Checking for ${date_Y-m-d}_diagnostic.tar.gz in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/iq_diagnostic directory
    [Tags]               IQ_Diagnostic
    ${des_iq_diag}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/iq_diagnostic/${date_Y-m-d}_diagnostic.tar.gz
    Set Global Variable    ${des_iq_diag}
    Log To Console    ${des_iq_diag}
    IF    ${des_iq_diag} == True
    ${des_iq_diag_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/iq_diagnostic/${date_Y-m-d}_diagnostic.tar.gz
    Set Global Variable    ${des_iq_diag_size}
    Run Keyword If   ${des_iq_diag_size}==0   Fail    Size is zero.
    ELSE
        Fail   ${date_Y-m-d}_diagnostic.tar.gz log and size is not there in the destination path
    END