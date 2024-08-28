*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for engineHeap file in heapMemory source TC01
    [Documentation]      Checking for engineHeap-${date_Y-m-d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               Heap_Memory
    Check File Exists    /eniq/log/sw_log/engine/engineHeap-${date_Y-m-d}.log

Checking for engineHeap file size in heapMemory source TC02
    Depends on test      Checking for engineHeap file in heapMemory source TC01
    [Documentation]      Checking for non empty engineHeap-${date_Y-m-d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               Heap_Memory
    Check File Size      /eniq/log/sw_log/engine/engineHeap-${date_Y-m-d}.log

Checking for engineHeap file in heapMemory destination TC03
    Depends on test      Checking for engineHeap file size in heapMemory source TC02
    [Documentation]      Checking for engineHeap-${date_Y-m-d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory directory
    [Tags]               Heap_Memory
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory/engineHeap-${date_Y-m-d}.log

Checking for engineHeap file size in heapMemory destination TC04
    Depends on test      Checking for engineHeap file in heapMemory destination TC03
    [Documentation]      Checking for non empty engineHeap-${date_Y-m-d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory directory
    [Tags]               Heap_Memory
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory/engineHeap-${date_Y-m-d}.log

Checking for schedulerHeap file in heapMemory source TC05
    [Documentation]      Checking for schedulerHeap-${date_Y-m-d}.log file in /eniq/log/sw_log/scheduler directory
    [Tags]               Heap_Memory
    Check File Exists    /eniq/log/sw_log/scheduler/schedulerHeap-${date_Y-m-d}.log

Checking for schedulerHeap file size in heapMemory source TC06
    Depends on test      Checking for schedulerHeap file in heapMemory source TC05
    [Documentation]      Checking for non empty schedulerHeap-${date_Y-m-d}.log file in /eniq/log/sw_log/scheduler directory
    [Tags]               Heap_Memory
    Check File Size      /eniq/log/sw_log/scheduler/schedulerHeap-${date_Y-m-d}.log

Checking for schedulerHeap file in heapMemory destination TC07
    Depends on test      Checking for schedulerHeap file size in heapMemory source TC06
    [Documentation]      Checking for schedulerHeap-${date_Y-m-d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory directory
    [Tags]               Heap_Memory
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory/schedulerHeap-${date_Y-m-d}.log

Checking for schedulerHeap file size in heapMemory destination TC08
    Depends on test      Checking for schedulerHeap file in heapMemory destination TC07
    [Documentation]      Checking for non empty schedulerHeap-${date_Y-m-d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory directory
    [Tags]               Heap_Memory
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/heapMemory/schedulerHeap-${date_Y-m-d}.log
