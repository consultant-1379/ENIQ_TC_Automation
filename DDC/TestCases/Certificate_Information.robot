*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for Certificate_Expiry file in CI source TC01
    [Documentation]      Checking for Certificate_Expiry_${date_Y-m-d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               Certificate_Information
    ${src_crt_exp}=      Run Keyword And Return Status    Check File Exists    /eniq/log/sw_log/engine/Certificate_Expiry_${date_Y-m-d}.log
    Set Global Variable    ${src_crt_exp}
    Log To Console    ${src_crt_exp}
    IF    ${src_crt_exp} == True
        Pass Execution    Certificate_Expiry log file is available.
    ELSE
        ${skip_exe}=    Execute Command      cd  /eniq/sw/bin
        ${collect_script}=    Execute Command    ./collect_certifictaes.bsh
        Set Global Variable    ${skip_exe}
        Set Global Variable    ${collect_script}
        Skip   Certificate_Expiry_${date_Y-m-d}.log file is not available as collection didn't happened.
    END
	
Checking for Certificate_Expiry file size in CI source TC02
    Depends on test      Checking for Certificate_Expiry file in CI source TC01
    [Documentation]      Checking for non empty Certificate_Expiry_${date_Y-m-d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               Certificate_Information
    Check File Size      /eniq/log/sw_log/engine/Certificate_Expiry_${date_Y-m-d}.log

Checking for Certificate_Expiry file in CI destination TC03
    Depends on test      Checking for Certificate_Expiry file size in CI source TC02
    [Documentation]      Checking for Certificate_Expiry_${date_Y-m-d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory directory
    [Tags]               Certificate_Information
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory/Certificate_Expiry_${date_Y-m-d}.log

Checking for Certificate_Expiry file size in CI destination TC04
    Depends on test      Checking for Certificate_Expiry file in CI destination TC03
    [Documentation]      Checking for non empty Certificate_Expiry_${date_Y-m-d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory directory
    [Tags]               Certificate_Information
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory/Certificate_Expiry_${date_Y-m-d}.log
