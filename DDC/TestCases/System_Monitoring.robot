*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for engine file in System Monitoring source TC01
    [Documentation]      Checking for engine-${curr_date_Y_m_d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               System_Monitoring_engine
    ${engine}=     Run Keyword And Return Status    Check File Exists    /eniq/log/sw_log/engine/engine-${curr_date_Y_m_d}.log
    Set Global Variable    ${engine}
    Log To Console    ${engine}
    Run Keyword If    ${engine} == False    Skip    engine log is not there in the source path

Checking for engine file size in System Monitoring source TC02
    Skip If    ${engine} == False
    Depends on test      Checking for engine file in System Monitoring source TC01
    [Documentation]      Checking for non empty engine-${curr_date_Y_m_d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               System_Monitoring_engine
    Check File Size      /eniq/log/sw_log/engine/engine-${curr_date_Y_m_d}.log

Checking for loaderAggregatorSetFailure file and size in System Monitoring source TC03
    Skip If    ${engine} == False
    [Documentation]      Checking for loaderAggregatorSetFailure_${date_Y-m-d}.txt file in /eniq/log/assureddc/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_loaderAggregatorSetFailure
    ${src_loader}=     Run Keyword And Return Status     Check File Exists    /eniq/log/assureddc/loaderAggregatorSetFailure/loaderAggregatorSetFailure_${date_Y-m-d}.txt
    Set Global Variable    ${src_loader}
    Log To Console    ${src_loader}
    IF    ${src_loader} == True
    ${src_loader_size}=    Check File Size New      /eniq/log/assureddc/loaderAggregatorSetFailure/loaderAggregatorSetFailure_${date_Y-m-d}.txt
    Set Global Variable    ${src_loader_size}
    Run Keyword If   ${src_loader_size}==0   Fail    Size is zero.
    ELSE
        Skip   loaderAggregatorSetFailure file and size is not there in the source path
    END

Checking for loaderAggregatorSetFailure file in System Monitoring destination TC04
    Skip If    ${src_loader} == False
    Depends on test      Checking for loaderAggregatorSetFailure file and size in System Monitoring source TC03
    [Documentation]      Checking for loaderAggregatorSetFailure_${date_Y-m-d}.txt in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_loaderAggregatorSetFailure
    ${des_loader}=     Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure/loaderAggregatorSetFailure_${date_Y-m-d}.txt
    Set Global Variable    ${des_loader}
    Log To Console    ${des_loader}
    IF    ${des_loader} == True
    ${des_loader_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure/loaderAggregatorSetFailure_${date_Y-m-d}.txt
    Set Global Variable    ${des_loader_size}
    Run Keyword If   ${des_loader_size}==0   Fail    Size is zero.
    ELSE
        Fail   loaderAggregatorSetFailure file and size is not there in the destination path
    END

Checking for delimiterErrorLoaderSet file and size in System Monitoring source TC05
    [Documentation]      Checking for delimiterErrorLoaderSet_${date_Y-m-d}.txt file in /eniq/log/assureddc/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_delimiterErrorLoaderSet
    ${src_delimitererror}=     Run Keyword And Return Status    Check File Exists    /eniq/log/assureddc/loaderAggregatorSetFailure/delimiterErrorLoaderSet_${date_Y-m-d}.txt
    Set Global Variable    ${src_delimitererror}
    Log To Console    ${src_delimitererror}
    IF    ${src_delimitererror} == True
    ${src_delimitererror_size}=    Check File Size New      /eniq/log/assureddc/loaderAggregatorSetFailure/delimiterErrorLoaderSet_${date_Y-m-d}.txt
    Set Global Variable    ${src_delimitererror_size}
    Run Keyword If   ${src_delimitererror_size}==0   Fail    Size is zero.
    ELSE
        Skip   delimiterErrorLoaderSet log and size is not there in the source path
    END

Checking for delimiterErrorLoaderSet file and size in System Monitoring destination TC06
    Skip If    ${src_delimitererror} == False
    Depends on test      Checking for delimiterErrorLoaderSet file and size in System Monitoring source TC05
    [Documentation]      Checking for delimiterErrorLoaderSet_${date_Y-m-d}.txt in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_delimiterErrorLoaderSet
    ${des_delimitererror}=     Run Keyword And Return Status    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure/delimiterErrorLoaderSet_${date_Y-m-d}.txt
    Set Global Variable    ${des_delimitererror}
    Log To Console    ${des_delimitererror}
    IF    ${des_delimitererror} == True
    ${des_delimitererror_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure/delimiterErrorLoaderSet_${date_Y-m-d}.txt
    Set Global Variable    ${des_delimitererror_size}
    Run Keyword If   ${des_delimitererror_size}==0   Fail    Size is zero.
    ELSE
        Fail  delimiterErrorLoaderSet log and size is not there in the destination path
    END

Checking for storage_fs_list file in System Monitoring source TC07
    [Documentation]      Checking for storage_fs_list.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts directory
    [Tags]               System_Monitoring_storage_fs_list
    ${output}=           Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/remotehosts -type f -name 'storage_fs_list.txt'
    Set Global Variable    ${output}
    ${storagefs}=     Run Keyword And Return Status    Check File Exists      ${output}
    Set Global Variable    ${storagefs}
    Log To Console    ${storagefs}
    IF    ${storagefs} == True
    ${storagefs_size}=    Check File Size New      ${output}
    Set Global Variable    ${storagefs_size}
    Run Keyword If   ${storagefs_size}==0   Fail    Size is zero.
    ELSE
        Skip   storage_fs_list log and size is not there in the source path
    END

Checking for sfsSnapCacheStatus file in System Monitoring source TC08
    [Documentation]      Checking for sfsSnapCacheStatus_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sfsSnapCacheStatus directory
    [Tags]               System_Monitoring_sfsSnapCacheStatus
    ${sfssnap}=     Run Keyword And Return Status    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sfsSnapCacheStatus/sfsSnapCacheStatus_${date_Y-m-d}.txt
    Set Global Variable    ${sfssnap}
    Log To Console    ${sfssnap}
    IF    ${sfssnap} == True
    ${sfssnap_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/sfsSnapCacheStatus/sfsSnapCacheStatus_${date_Y-m-d}.txt
    Set Global Variable    ${sfssnap_size}
    Run Keyword If   ${sfssnap_size}==0   Fail    Size is zero.
    ELSE
        Skip   sfsSnapCacheStatus log and size is not there in the source path
    END

Checking for eniqServiceRestart file in System Monitoring source TC09
    [Documentation]      Checking for eniqServiceRestart-${date_Y-m-d}.txt file in /tmp directory
    [Tags]               System_Monitoring_eniqServiceRestart
    ${eniq_service}=     Run Keyword And Return Status    Check File Exists    /tmp/eniqServiceRestart-${date_Y-m-d}.txt
    Set Global Variable    ${eniq_service}
    Log To Console    ${eniq_service}
    Run Keyword If    ${eniq_service} == False    Skip    eniqServiceRestart file is not there in the source path


#Checking for eniqServiceRestart file size in System Monitoring source TC10
#    Skip If    ${eniq_service} == False
#    Depends on test      Checking for eniqServiceRestart file in System Monitoring source TC09
#    [Documentation]      Checking for eniqServiceRestart-${date_Y-m-d}.txt file in /tmp directory
#    [Tags]               System_Monitoring_eniqServiceRestart
#    Check File Size      /tmp/eniqServiceRestart-${date_Y-m-d}.txt

Checking for eniqServiceRestart file in System Monitoring destination TC10
    Skip If    ${eniq_service} == False
    Depends on test      Checking for eniqServiceRestart file in System Monitoring source TC09
    [Documentation]      Checking for eniqServiceRestart-${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniqServiceRestart directory
    [Tags]               System_Monitoring_eniqServiceRestart
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniqServiceRestart/eniqServiceRestart-${date_Y-m-d}.txt

#Checking for eniqServiceRestart file size in System Monitoring destination TC12
#    Skip If    ${eniq_service} == False
#    Depends on test      Checking for eniqServiceRestart file in System Monitoring destination TC11
#    [Documentation]      Checking for non empty eniqServiceRestart-${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniqServiceRestart directory
#    [Tags]               System_Monitoring_eniqServiceRestart
#    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniqServiceRestart/eniqServiceRestart-${date_Y-m-d}.txt
