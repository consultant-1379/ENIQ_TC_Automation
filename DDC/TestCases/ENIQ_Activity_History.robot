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
Checking for eniq_activity file in source TC01
    [Documentation]       Checking for eniq_activity_history file in /eniq/local_logs directory
    [Tags]                ENIQ_Activity_History
    ${static_version}     Set Variable   23.4
    Set Global Variable    ${static_version}
    Log To Console   ${static_version}
    ${eniq_his_log}=     Run Keyword And Return Status     Check File Exists    /eniq/local_logs/eniq_activity_history.log
    Set Global Variable    ${eniq_his_log}
    Log To Console    ${eniq_his_log}
    ${eniq_rel_version}=          Execute Command    cat /eniq/admin/version/eniq_history | awk '/Shipment/ {print}' | cut -d "_" -f 5 | cut -d "." -f 1,2
    Set Global Variable    ${eniq_rel_version}
    Log To Console   ${eniq_rel_version}
    IF    ${eniq_his_log} == True
        Pass Execution    eniq_activity_history.log is present in /eniq/local_logs directory
    ELSE
        IF    ${eniq_rel_version} >= ${static_version}
            Fail   eniq_activity_history.log is not there in /eniq/local_logs directory
        ELSE
            Skip    Test cases are skipped because release is less than 23.4
        END
    END

Checking for eniq_activity file size in source TC02
    Depends on test       Checking for eniq_activity file in source TC01
    [Documentation]       Checking for non empty eniq_activity_history file in /eniq/local_logs directory
    [Tags]                ENIQ_Activity_History
    Check File Size       /eniq/local_logs/eniq_activity_history.log

Checking for eniq_activity file in destination TC03
    Depends on test            Checking for eniq_activity file size in source TC02
    [Documentation]            Checking for eniq_activity_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniq_activity_history directory
    [Tags]                     ENIQ_Activity_History
    ${des_eniq_log_file}=      Execute Command    find /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniq_activity_history -name "eniq_activity_history*.json"
    Set Global Variable        ${des_eniq_log_file}
    Check File Exists          ${des_eniq_log_file}

Checking for eniq_activity file size in destination TC04
    Depends on test       Checking for eniq_activity file in destination TC03
    [Documentation]       Checking for non empty eniq_activity_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/eniq_activity_history directory
    [Tags]                ENIQ_Activity_History
    Check File Size       ${des_eniq_log_file}
