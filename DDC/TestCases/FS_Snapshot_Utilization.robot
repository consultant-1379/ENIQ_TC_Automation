*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for prep_roll_snap file in snapshot source TC01
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/local_logs/rolling_snapshot_logs directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/local_logs/rolling_snapshot_logs/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot source TC02
    Depends on test        Checking for prep_roll_snap file in snapshot source TC01
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/local_logs/rolling_snapshot_logs directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/local_logs/rolling_snapshot_logs/prep_roll_snap.log

Checking for prep_roll_snap file in snapshot destination TC03
    Depends on test        Checking for prep_roll_snap file size in snapshot source TC02
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot destination TC04
    Depends on test        Checking for prep_roll_snap file in snapshot destination TC03
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log
