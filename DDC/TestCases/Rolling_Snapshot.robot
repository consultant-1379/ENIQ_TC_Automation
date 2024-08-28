*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for prep_roll_snap file in rolling source TC01
    [Documentation]       Checking for prep_roll_snap.log file in /eniq/local_logs/rolling_snapshot_logs directory
    [Tags]                Rolling_Snapshot
    Check File Exists     /eniq/local_logs/rolling_snapshot_logs/prep_roll_snap.log

Checking for prep_roll_snap file size in rolling source TC02
    Depends on test       Checking for prep_roll_snap file in rolling source TC01
    [Documentation]       Checking for non empty prep_roll_snap.log file in /eniq/local_logs/rolling_snapshot_logs directory
    [Tags]                Rolling_Snapshot
    Check File Size       /eniq/local_logs/rolling_snapshot_logs/prep_roll_snap.log

Checking for prep_roll_snap file in rolling destination TC03
    Depends on test       Checking for prep_roll_snap file size in rolling source TC02
    [Documentation]       Checking for Rolling_Snapshot_${date_Y-m-d} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                Rolling_Snapshot
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file size in rolling destination TC04
    Depends on test       Checking for prep_roll_snap file in rolling destination TC03
    [Documentation]       Checking for non empty Rolling_Snapshot_${date_Y-m-d} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                Rolling_Snapshot
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log
