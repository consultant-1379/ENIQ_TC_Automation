*** Settings ***
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for prep_roll_snap file in snapshot source
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/local_logs/rolling_snapshot_logs directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/local_logs/rolling_snapshot_logs/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot source
    Depends on test        Checking for prep_roll_snap file in snapshot source
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/local_logs/rolling_snapshot_logs directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/local_logs/rolling_snapshot_logs/prep_roll_snap.log

Checking for prep_roll_snap file in snapshot destination
    Depends on test        Checking for prep_roll_snap file size in snapshot source
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot destination
    Depends on test        Checking for prep_roll_snap file in snapshot destination
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file in snapshot engine destination
    Depends on test        Checking for prep_roll_snap file in snapshot source
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot engine destination
    Depends on test        Checking for prep_roll_snap file in snapshot engine destination
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/log/ddc_data/${hostname_engine}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file in snapshot reader_1 destination
    Depends on test        Checking for prep_roll_snap file in snapshot source
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot reader_1 destination
    Depends on test        Checking for prep_roll_snap file in snapshot reader_1 destination
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/log/ddc_data/${hostname_reader_1}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file in snapshot reader_2 destination
    Depends on test        Checking for prep_roll_snap file in snapshot source
    [Documentation]        Checking for prep_roll_snap.log file in /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Exists      /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log

Checking for prep_roll_snap file size in snapshot reader_2 destination
    Depends on test        Checking for prep_roll_snap file in snapshot reader_2 destination
    [Documentation]        Checking for non empty prep_roll_snap.log file in /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/Rolling_Snapshot directory
    [Tags]                 FS_Snapshot_Utilization
    Check File Size        /eniq/log/ddc_data/${hostname_reader_2}/${date_dmy}/plugin_data/Rolling_Snapshot/prep_roll_snap.log
