*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for os_rhel_memory_profile file in OS source TC01
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /tmp directory
    [Tags]                os_Memory_Profile
    Check File Exists     /tmp/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS source TC02
    Depends on test       Checking for os_rhel_memory_profile file in OS source TC01
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /tmp directory
    [Tags]                os_Memory_Profile
    Check File Size       /tmp/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file in OS destination TC03
    Depends on test       Checking for os_rhel_memory_profile file size in OS source TC02
    [Documentation]       Checking for os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile directory
    [Tags]                os_Memory_Profile
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt

Checking for os_rhel_memory_profile file size in OS destination TC04
    Depends on test       Checking for os_rhel_memory_profile file in OS destination TC03
    [Documentation]       Checking for non empty os_rhel_memory_profile_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile directory
    [Tags]                os_Memory_Profile
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/osMemoryProfile/os_rhel_memory_profile_${date_Y-m-d}.txt
